const baseURL = "http://localhost:8080";

function displayColors(data) { 
   let tbl = "";

   // For each item in JSON, create div row with columns 
   $.each(data.rows, function(index, row) {
      tbl += "<div class='row'>\n";
      tbl += "<div class='col1'>" + row.COLOR_ID + "</div>\n";
      tbl += "<div class='col2'>" + row.COLOR_NAME + "</div>\n"; 
      tbl += "<div class='col3'>" + row.COLOR_HEX + "</div>\n";
      tbl += "<div class='col4'>";
      tbl += "<button id='" + row.COLOR_ID + "' onclick='showEditForm(this)'>Edit</button>&nbsp;";
      tbl += "<button id='" + row.COLOR_ID + "' onclick='deleteColor(this)'>Delete</button>";
      tbl += "</div>\n";
      tbl += "</div>\n";
   });
   // Append tbl data to container div after first removing all rows but header 
   $("#outputDiv").children("div:not(:first)").remove(); 
   $("#outputDiv").append(tbl);
}

function getColors() { 
   console.log("Requesting colors...");
   $.ajax({
      url: baseURL + "/colors/",
      type: "GET",
      dataType: "json",
      success: function(data, status) {
         console.log("Colors received");
         displayColors(data);
      },
      error: function (xhr, status) { 
         console.log("Error: ", status);
      }
   });
}

function deleteColor(me) {
   console.log("Deleting color...");
   let id = me.id;
   $.ajax({
      url: baseURL + "/colors/" + id,
      type: "DELETE",
      dataType: "json",
      data: {},
      success: function(data, status) {
         console.log("Color deleted");
         getColors();
      },
      error: function (xhr, status) {
         console.log("Error: ", status);
      }
   });
}

function addColor() {
   console.log("Adding color...");
   let color = document.querySelector("#color").value;
   let hex = document.querySelector("#hex").value;
   $.ajax({
      url: baseURL + "/colors/",
      type: "POST",
      dataType: "json",
      data: {color: color, hex: hex},
      success: function(data, status) {
         console.log("Color added");
         getColors();
      },
      error: function (xhr, status) {
         console.log("Error: ", status);
      }
   });
}

function showEditForm(me){
   document.querySelector(".editPanel").style.visibility = 'visible'
   document.querySelector("#idEdit").value = me.id
}

function editColor() {
   console.log("Updating color...");
   let color = document.querySelector("#colorEdit").value;
   let hex = document.querySelector("#hexEdit").value;
   let id = document.querySelector("#idEdit").value
   $.ajax({
      url: baseURL + "/colors/",
      type: "PUT",
      dataType: "json",
      data: {color: color, hex: hex, id: id},
      success: function(data, status) {
         console.log("Color edited");
	 document.querySelector("#colorEdit").value = "";
   	 document.querySelector("#hexEdit").value = "";
         document.querySelector(".editPanel").style.visibility = 'hidden'
         getColors();
      },
      error: function (xhr, status) {
         console.log("Error: ", status);
      }
   });
}

$(document).ready(function() {
   $("#addColorButton").on('click', addColor);
   $("#editColorButton").on('click', editColor);
   getColors();
});