# SaveToDB Examples for SQLite

SaveToDB examples show various features of the applications built with SQLite and the following client apps:

- [SaveToDB add-in for Microsoft Excel](https://www.savetodb.com/savetodb.htm)
- [DBEdit for Windows](https://www.savetodb.com/dbedit.htm)
- [DBGate for Windows and Linux](https://www.savetodb.com/dbgate.htm)
- [ODataDB for Windows and Linux](https://www.savetodb.com/odatadb.htm)

To try examples with Excel, download the [SaveToDB SDK](https://www.savetodb.com/download.htm) which includes the source codes and workbooks.

Some samples have no configuration and show the features from the box.

Other samples have the configured features. Refer to the [Developer Guide](https://www.savetodb.com/dev-guide/getting-started.htm) for details.

Such samples use [SaveToDB Framework for SQLite](https://github.com/savetodb/savetodb-framework-for-sqlite).


## Manual installation, update, and uninstallation

### Installation

To install the example, execute the following files from the example folder in the following order:

1. savetodb-framework-install.sql (if exists)
2. application-install.sql

Omit the SaveToDB framework file if you already installed them with another example.

### Update

SaveToDB samples do not support updating. However, you may update SaveToDB frameworks separately.

### Uninstallation

To remove the example, execute the following files from the example folder in the following order:

1. application-remove.sql
2. savetodb-framework-remove.sql (if exists)


## Installation and uninstallation with DBSetup

DBSetup is a free command-line tool to automate install and uninstall operations.

It is shipped with [SaveToDB SDKs](https://www.savetodb.com/download.htm), [SaveToDB add-in](https://www.savetodb.com/savetodb.htm), and [DBEdit](https://www.savetodb.com/dbedit.htm)..

We recommend installing it with gsqlcmd, another free useful tool for database developers.

To install or uninstall the example, edit the setup connection string in the gsqlcmd.exe.config file and run `dbsetup` in Windows or `dotnet dbsetup` in Linux. Then follow command-line instructions.


## License

The SaveToDB examples are licensed under the MIT license.
