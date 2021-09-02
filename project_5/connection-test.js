let mysql = require('mysql2');
let dbInfo = require('./dbInfo.js');

try {
   let connection = mysql.createConnection({
      host: dbInfo.dbHost,
      port: dbInfo.dbPort,
      user: dbInfo.dbUser,
      password: dbInfo.dbPassword,
      database: dbInfo.dbDatabase
   });

   connection.connect(function(err) {
      if (err) {
         console.log(JSON.stringify(err));
         throw err;
      }
      console.log('Connected to database, closing connection in 5 seconds...');
      setTimeout(function() {
         connection.end();
         console.log("Database connection closed")
      }, 5000);
   });
} catch (err) {
   console.log(err);
}