let mysql = require('mysql2');
let dbInfo = require('./dbInfo.js');
let express = require('express');
let bodyParser = require("body-parser");
let cors = require('cors');

let app = express();

// Add static route for non-Node.js pages
app.use(express.static('public'));

// Configure body parser for handling post operations
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Get colors
app.get('/colors/:COLOR_ID?', function (req, res) {
   console.log("Route /colors GET", req.params);
   let data = [];
   let sql = "SELECT * FROM COLOR";
   if (req.params.COLOR_ID != undefined) {
      sql += " WHERE COLOR_ID = ?";
      data = [req.params.COLOR_ID];
      // Object technique:
      // sql += " WHERE ?";
      // data = req.params;
      console.log(data);
   } else {
      sql += " ORDER BY COLOR_NAME";
   }
   console.log("SQL", sql);
   connection.query(sql, data,
      function (errQuery, rows) {
         if (errQuery) {
            console.log(errQuery);
            res.json({rows: [], err: errQuery});
         } else if (rows) {
            console.log("Rows returned", rows.length);
            res.json({rows: rows, err: ""});
         } else {
            console.log("No color rows...\n");
            res.json({rows: [], err: ""});
         }
      }
   );
});

// Add color
app.post('/colors', function (req, res) {
   console.log("Route /colors POST");
   let data = {COLOR_NAME: req.body.color, COLOR_HEX: req.body.hex};
   connection.query("INSERT INTO COLOR SET ?", 
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Insert ID: ", result.insertId);
            res.json({status: result.insertId, err: ""});
         }
      }
   );
});

// Delete color
app.delete('/colors/:COLOR_ID?', function (req, res) {
   console.log("Route /colors DELETE");
   let sql = "DELETE FROM COLOR WHERE COLOR_ID = ?";
   // Object technique:
   // let sql = "DELETE FROM COLOR WHERE ?";
   if (req.params.COLOR_ID != undefined) {
      let data = [req.params.COLOR_ID];
      // Object technique:
      // let data = {COLOR_ID: req.params.COLOR_ID};
      connection.query(sql, 
         data, 
         function (errQuery, result) {
            if (errQuery) {
               console.log(errQuery);
               res.json({status: "Error", err: errQuery});
            } else {
               console.log("Deleted");
               res.json({status: "Deleted", err: ""});
            }
         }
      );
   } else {
      let s = "Invalid or missing COLOR_ID";
      console.log(s);
      res.json({status: "Error", err: s});
   }
});

// Update color
app.put('/colors', function (req, res) {
   console.log("Route /colors PUT");
   let data = [{COLOR_NAME: req.body.color, COLOR_HEX: req.body.hex}, req.body.color_id];
   connection.query("UPDATE COLOR SET ? WHERE COLOR_ID=?",  
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Updated ID: ", req.body.id, ", Affected Rows: ", result.affectedRows);
            res.json({status: req.body.id, err: "", message: "Row updated"});         }
      }
   );
});

// Use NodeJS as our web server, needed to prevent cross origin (CORS) error
// typically seen on Chrome
app.get('/color.css', function(req, res) {
   res.sendFile(__dirname + '/color.css');
});

app.get('/color.html', function(req, res) {
   res.sendFile(__dirname + '/color.html');
});

app.get('/color.js', function(req, res) {
   res.sendFile(__dirname + '/color.js');
});

app.get('/colors/:COLOR_ID?', cors(), function (req, res) {
    res.sendFile(__dirname + '/server-color.js');
});

// Handle missing pages requested using GET HTTP verb
app.get('*', function(req, res) {
   res.status(404).send('Sorry that page does not exist');
});

// Create database connection
console.log('Creating connection...\n');
let connection = mysql.createConnection({
   host: dbInfo.dbHost,
   port: dbInfo.dbPort,
   user: dbInfo.dbUser,
   password: dbInfo.dbPassword,
   database: dbInfo.dbDatabase
});
// Connect to database
connection.connect(function(err) {
   console.log('Connecting to database...\n');

   // Handle any errors
   if (err) {
      console.log(err);
      console.log('Exiting application...\n');
   } else {
      console.log('Connected to database...\n');
      // Listen for connections
      // Note: Will terminate with an error if database connection
      // is closed
      const ip = 'localhost';
      const port = 8080;
      app.listen(port, ip, function () {
         try {
            console.log('Color server app listening on port ' + port);
         } catch (err) {
            console.log(err);
         }
      });
   }
});