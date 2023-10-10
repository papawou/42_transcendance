sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/15/main/pg_hba.conf

service postgresql start

psql --command="CREATE DATABASE $DB_NAME;"

cat > configure.sql << EOF
CREATE USER $DB_USERNAME WITH PASSWORD '$DB_USERPWD';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USERNAME;
EOF

psql --file="./configure.sql"
psql --dbname=$DB_NAME --file="./init_database.sql"

service postgresql stop
