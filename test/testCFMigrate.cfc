component extends="mxunit.framework.TestCase" {
	variables.datasourceName = "cfmigration";
	variables.dbUsername = "";
	variables.dbPassword = "";
	variables.directoryName = getDirectoryFromPath(getCurrentTemplatePath()) & "testMigrations/";
	variables.directoryPath = "migrations.test.testMigrations";

	public void function setup() output="false" {
		variables.cfMigrate = new migrations.migrate(
			variables.datasourceName, 
			variables.dbUsername, 
			variables.dbPassword,
			false,
			variables.directoryName,
			variables.directoryPath);
	}

	public void function testSetup() output="false" {
		transaction {
			variables.cfMigrate.setup_migrations();
			local.infoArgs = {datasource = variables.datasourceName};

			local.dbInfo = new DBInfo(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword);
			local.tables = local.dbInfo.tables();
			local.qryTable = new Query(dbtype="query");
			local.qryTable.setAttributes(tables = local.tables);
			local.tableResult = local.qryTable.execute(sql="SELECT * FROM tables WHERE TABLE_NAME = 'migrations'").getResult();
			assertTrue(local.tableResult.recordcount, "Table record does not exist");
			transaction action="rollback";
		}
	}

	public void function testCreateMigration() output="false" {
		local.migrationFileName = variables.cfMigrate.create_migration("testMigration");
		local.exists = fileExists(local.migrationFileName);
		//Assuming creation was successful, delete the file
		if (local.exists) {
			fileDelete(local.migrationFileName);
		}

		assertTrue(local.exists, "Migration file was not created");
	}

	public void function testRunMigration_noVersion() output="false" {
		transaction {
			variables.cfMigrate.setup_migrations();
			variables.cfMigrate.run_migrations();
			local.verifyQuery = new Query(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword, sql="SELECT * FROM [migrations] ORDER BY [migration_number]").execute().getResult();
			local.tables = new DBInfo(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword).tables();
			local.qryTables = new Query(dbtype = "query");
			local.qryTables.setAttributes(tables = local.tables);
			local.verifyTest1 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test1'").getResult();
			local.verifyTest2 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test2'").getResult();
			transaction action="rollback";
		}

		assertEquals(2, local.verifyQuery.recordcount, "Migrations not recorded");
		assertEquals("20110101000000", local.verifyQuery.migration_number[1], "First migration not recorded");
		assertEquals("20110101010000", local.verifyQuery.migration_number[2], "Second migration not recorded");
		assertTrue(local.verifyTest1.recordcount, "Table test1 not created");
		assertTrue(local.verifyTest2.recordcount, "Table test2 not created");
	}

	public void function testRunMigrationTwice_noVersion() output="false" hint="Run existing migrations, then run again.  Should skip the previously run migrations, else a SQL error may result" {
		transaction {
			variables.cfMigrate.setup_migrations();
			variables.cfMigrate.run_migrations();
			variables.cfMigrate.run_migrations();
			local.verifyQuery = new Query(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword, sql="SELECT * FROM [migrations] ORDER BY [migration_number]").execute().getResult();
			local.tables = new DBInfo(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword).tables();
			local.qryTables = new Query(dbtype = "query");
			local.qryTables.setAttributes(tables = local.tables);
			local.verifyTest1 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test1'").getResult();
			local.verifyTest2 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test2'").getResult();
			transaction action="rollback";
		}

		assertEquals(2, local.verifyQuery.recordcount, "Migrations not recorded");
		assertEquals("20110101000000", local.verifyQuery.migration_number[1], "First migration not recorded");
		assertEquals("20110101010000", local.verifyQuery.migration_number[2], "Second migration not recorded");
		assertTrue(local.verifyTest1.recordcount, "Table test1 not created");
		assertTrue(local.verifyTest2.recordcount, "Table test2 not created");
	}

	public void function testRunMigration_invalidVersion() output="false" hint="Provide an invalid migration ID, should return an exception" {
		expectException("cfmigrate.invalid");
		transaction {
			variables.cfMigrate.setup_migrations();
			variables.cfMigrate.run_migrations("20110202000000");
			transaction action="rollback";
		}
	}

	public void function testRunMigration_rollback() output="false" hint="Rollback to the first migration" {
		transaction {
			variables.cfMigrate.setup_migrations();
			variables.cfMigrate.run_migrations();
			variables.cfMigrate.run_migrations("20110101000000");
			local.verifyQuery = new Query(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword, sql="SELECT * FROM [migrations] ORDER BY [migration_number]").execute().getResult();
			local.tables = new DBInfo(datasource = variables.datasourceName, username = variables.dbUsername, password = variables.dbPassword).tables();
			local.qryTables = new Query(dbtype = "query");
			local.qryTables.setAttributes(tables = local.tables);
			local.verifyTest1 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test1'").getResult();
			local.verifyTest2 = local.qryTables.execute(sql = "SELECT * FROM tables WHERE TABLE_NAME = 'test2'").getResult();
			transaction action="rollback";
		}

		assertEquals(1, local.verifyQuery.recordcount, "Migrations not recorded");
		assertEquals("20110101000000", local.verifyQuery.migration_number[1], "First migration not recorded");
		assertTrue(local.verifyTest1.recordcount, "Table test1 not created");
		assertFalse(local.verifyTest2.recordcount, "Table test2 not removed");
	}

	public void function testTestSetup_false() output="false" {
		assertFalse(variables.cfMigrate.test_setup(), "[migrations] table should not exist, this should be false");
	}

	public void function testTestSetup_true() output="false" {
		transaction {
			variables.cfMigrate.setup_migrations();
			local.isSetup = variables.cfMigrate.test_setup();
			transaction action="rollback";
		}

		assertTrue(local.isSetup, "[migrations] table should exists, this should be true");
	}
}
