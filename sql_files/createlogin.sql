--login for sql on premise database: IPL

CREATE LOGIN neeraj WITH PASSWORD = 'local_db@ipl#=2017';

CREATE USER neeraj FOR LOGIN neeraj

--assigned db_datareader role for the user 'neeraj' under users.membership
--thereby user 'neeraj' has reader access to read all tables in database: IPL
--so, now we can use this password & login in AZURE to connect to this database.local_db@ipl#=2017