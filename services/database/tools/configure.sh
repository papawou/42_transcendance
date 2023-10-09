sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf

service postgresql start

cat > configure.sql << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USERNAME' WITH PASSWORD '$DB_USERPWD';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME to $DB_USERNAME WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

psql --dbname=$DB_NAME < ./configure.sql
psql --dbname=$DB_NAME < ./init_database.sql

service postgresql stop
