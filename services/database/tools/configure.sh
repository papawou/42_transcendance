sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/15/main/pg_hba.conf

service postgresql start

psql --command="CREATE DATABASE $DB_NAME;"

cat > configure.sql << EOF
CREATE USER $DB_USERNAME WITH PASSWORD '$DB_USERPWD';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USERNAME;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USERNAME;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO $DB_USERNAME;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO $DB_USERNAME;
EOF

psql --dbname=$DB_NAME --file="./configure.sql"
psql --dbname=$DB_NAME --file="./init_database.sql"

service postgresql stop
