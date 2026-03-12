import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:elf_flutter/data/table/conservations_table.dart';
import 'package:elf_flutter/data/table/messages_table.dart';



part 'chat_database.g.dart';

@DriftDatabase(
  tables: [
    Conversations,
    Messages,
  ],
)
class ChatDatabase extends _$ChatDatabase {

  ChatDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            // Add the new lastActiveAt column.
            // We back-fill it with createdAt so existing rows are valid.
            await migrator.addColumn(
              conversations,
              conversations.lastActiveAt,
            );
            await customStatement(
              'UPDATE conversations SET last_active_at = created_at',
            );
          }
        },
      );

}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'chat_db',
  );
}
