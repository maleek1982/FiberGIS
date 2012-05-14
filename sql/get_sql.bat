@echo Start...
@echo off

PATH=%PATH%;C:/Program Files/PostgreSQL/8.4/bin/

set SCHEMA_ONLY=--host %1 --port %2 --username %3 --schema-only --no-owner
set DATA_ONLY=--host %1 --port %2 --username %3 --format plain --data-only --column-inserts

set DB=gis_2011
set gisetz_dump=../../gisetz_dump
set gisetz_repository_dump=../../gisetz_repository_dump

pg_dump.exe %SCHEMA_ONLY% --schema=gisetz -Fc -v --file %gisetz_dump% %DB%
pg_dump.exe %SCHEMA_ONLY% --schema=gisetz_repository -Fc -v --file %gisetz_repository_dump% %DB%

@echo ---
@echo Get tables from schema gisetz, gisetz_repository
del /Q "./schemas/gisetz/tables/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz.tables.txt") do (
    echo %%i
    pg_dump.exe %SCHEMA_ONLY% --format plain --file ./schemas/gisetz/tables/%%i.sql --table gisetz.%%i %DB%
)

del /Q "./schemas/gisetz_repository/tables/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz_repository.tables.txt") do (
    echo %%i
    pg_dump.exe %SCHEMA_ONLY% --format plain --file ./schemas/gisetz_repository/tables/%%i.sql --table gisetz_repository.%%i %DB%
)

del /Q "./schemas/gisetz_crm/tables/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz_crm.tables.txt") do (
    echo %%i
    pg_dump.exe %SCHEMA_ONLY% --format plain --file ./schemas/gisetz_crm/tables/%%i.sql --table gisetz_crm.%%i %DB%
)

@echo ---
@echo Get functions from schema Gisetz
del /Q "./schemas/gisetz/functions/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz.functions.txt") do (
    echo %%i
    pg_restore.exe -l %gisetz_dump% | findstr /C:"%%i" > ../../temp_list
    pg_restore.exe -O -L ../../temp_list %gisetz_dump% > ./schemas/gisetz/functions/%%i.sql 
)

@echo ---
@echo Get Triger functions from schema gisetz, gisetz_repository
del /Q "./schemas/gisetz/trigger functions/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz.trigger functions.txt") do (
    echo %%i
    pg_restore.exe -l %gisetz_dump% | findstr /C:"%%i" > ../../temp_list
    pg_restore.exe -O -L ../../temp_list %gisetz_dump% > "./schemas/gisetz/trigger functions/%%i.sql"
)

del /Q "./schemas/gisetz_repository/trigger functions/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz_repository.trigger functions.txt") do (
    echo %%i
    pg_restore.exe -l %gisetz_repository_dump% | findstr /C:"%%i" > ../../temp_list
    pg_restore.exe -O -L ../../temp_list %gisetz_repository_dump% > "./schemas/gisetz_repository/trigger functions/%%i.sql"
)

@echo ---
@echo Get Views from schema Gisetz
del /Q "./schemas/gisetz/views/"
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz.views.txt") do (
    echo %%i
    pg_restore.exe -l %gisetz_dump% | findstr /C:"%%i" > ../../temp_list
    pg_restore.exe -O -L ../../temp_list %gisetz_dump% > "./schemas/gisetz/views/%%i.sql"
)

@echo ---
@echo Get Data from public.geometry_columns
    pg_dump.exe --host %1 --port %2 --username %3 --format plain --data-only --column-inserts --file "./schemas/public/data/geometry_columns.sql" --table public.geometry_columns %DB%

@echo Get Data from schema gisetz_repository
for /f "eol=# tokens=* usebackq" %%i in ("./gisetz_repository.data.txt") do (
    echo %%i
    pg_dump.exe --host %1 --port %2 --username %3 --format plain --data-only --column-inserts --disable-triggers --file "./schemas/gisetz_repository/data/%%i.sql" --table gisetz_repository.%%i %DB%
)

PAUSE

