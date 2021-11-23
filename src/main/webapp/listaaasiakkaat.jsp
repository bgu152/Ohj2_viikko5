<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Listaa viikko5</title>
<style>
th {
	color:white;
	background:#4caf50;
	font-family: Arial;
	padding-left:10px;
	padding-right:10px;
}
.oikea{
	text-align:right;
}

th,td{
	text-align:left;
}

table{
	border-collapse: collapse;
}

td {
	border:1px solid #dddddd;
	
}
th {
	border:1px solid white;	
}

tr:nth-child(even){
	background: #f2f2f2;
}

</style>


</head>
<body>
<form>
<table id="listaus">

	<thead>	
		<tr>
			<th colspan =6	 class="oikea"> <span id ="uusiAsiakas">Lisää asiakas</span></th>
		<tr>
			<th  colspan = "4" height = 30px class="oikea"> Hakusana: </th>
			<th  height = 40px > <input type="text" size ="20"> </th>
			<th> <input type="button" value="Hae"> </th>
		</tr>			
		<tr>
			<th>Asiakas ID</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</form>
<script>
$(document).ready(function(){
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	$.ajax({url:"asiakkaat", type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
	
	
});

function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		console.log('Ajax start');
		var jsonStr = JSON.stringify({'asiakas_id':asiakas_id});
		$.ajax({url:"asiakkaat", type:"DELETE", data:jsonStr, dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
			console.log('Ajax running');    
		if(result.response==0){
	        	console.log('reply = 0');
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	console.log('reply = 1');
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
				location.reload();        	
			}else{
				console.log('no reply');
			}
	    }});
	}
}

</script>

</body>
</html>