#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Verifica se o banco de dados 'sonar' já existe
    DO
    \$\$
    BEGIN
        IF EXISTS (
            SELECT FROM pg_database WHERE datname = 'sonar'
        ) THEN
            -- Opção 1: Não fazer nada se o banco de dados já existir
            -- RAISE NOTICE 'Database sonar already exists.';

            -- Opção 2: Excluir e recriar o banco de dados
            -- ATENÇÃO: Esta operação irá deletar todos os dados existentes no banco de dados 'sonar'
            RAISE NOTICE 'Deleting existing database sonar.';
            EXECUTE 'DROP DATABASE sonar';
            RAISE NOTICE 'Creating database sonar with UTF8 encoding.';
            EXECUTE 'CREATE DATABASE sonar WITH ENCODING ''UTF8'' LC_COLLATE=''en_US.utf8'' LC_CTYPE=''en_US.utf8'' TEMPLATE=template0;';
        ELSE
            RAISE NOTICE 'Creating database sonar with UTF8 encoding.';
            EXECUTE 'CREATE DATABASE sonar WITH ENCODING ''UTF8'' LC_COLLATE=''en_US.utf8'' LC_CTYPE=''en_US.utf8'' TEMPLATE=template0;';
        END IF;
    END
    \$\$
EOSQL