<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Lisää viikko5</title>
</head>
<body>

<form id='tiedot'>
	<table>
		<thead>
					<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>	
			<th></th>	
			</tr>		
		</thead>
		<tbody>
			<tr>
				<th><input type="text" size="20" name="enimi" id="enimi"></th>
				<th><input type="text" size="20" name="snimi" id="snimi"></th>
				<th><input type="text" size="20" name="puh" id="puh"></th>
				<th><input type="text" size="20" name="sposti" id="sposti"></th>
				<th><input type="submit" size="20" id="tallenna" value="Lisää" ></th>
			</tr>
		
		
		</tbody>
	</table>
</form>

<span id="ilmo"></span>

<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	$("#tiedot").validate({
		
		rules: {
			enimi:  {
				required: true,
				minlength: 2				
			},	
			snimi:  {
				required: true,
				minlength: 2				
			},
			puh:  {
				required: true,
				minlength: 5
			},	
			sposti:  {
				required: true,
				minlength: 5
			}	
		},
		messages: {
			enimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			snimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puh: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}		
	}); 	
});
//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//POST /asiakkaat/
function lisaaTiedot(){	
	console.log('lisaaasasiakas.jsp lisää tideot');
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		console.log('Ajax running');	
	if(result.response==0){
      	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
      	$("#enimi", "#snimi", "#puh", "#sposti").val("");
		}
  }});	
}
</script>

</body>
</html>