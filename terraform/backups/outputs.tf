
output "pg_backup" {
  value = {
    bucket = one(module.pg_backup[*]),
    user = one(module.pg_backup_user[*]),
  }
  description = "PostgreSQL DB Backup"
}
