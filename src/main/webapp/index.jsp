<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>testing</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style type="text/css">
			#filecontents {
				border: single;
				overflow-y: scroll;
				overflow-x: scroll;
				height: 400px;
			}
		</style>
		<style type="text/css">
			#submit {
				text-align: center;
				margin: 0 auto;
			}
			

			.btn-group {

				color: black;
				/* White text */
				margin: 5px 20px;
				/* Some padding */
				width:auto;
				display: inline-block;
				/* Make the buttons appear below each other */
			}

			.row {
				padding-top: 10px;
				display: inline-block;
				text-align: right;
				float: center;

			}

			.column {
				text-align: right;
				float: left;
				width: 31%;
				padding: 10px;

			}

			.col {
				padding-top: 10px;
				text-align: right;
				float: left;

			}
			#filecontents {
    			-moz-tab-size: 4; /* Firefox */
    			-o-tab-size: 4; /* Opera 10.6-12.1 */
    			tab-size: 4;
			}
		</style>

		<body>
			<form method="post">
				<label for="file"> <span>Source/Target</span> <input
			type="text" />
		</label>
				<br/>
				<br/>
				

		<input type="file" id="txtfiletoread" name='txtfiletoread'  hidden/> 
		
				<br/>
				  <div style="width:100%">
					   <div style="text-align: center;float:left;width:10%;padding-top:0px"><p >Functions:</p>
				   		<div  style="border: 1px solid rgba(0, 0, 0, .5);height:392px">
							<p style="margin: 5px 20px;"></p>
							<button class = 'btn-group' type='button' id='printbtn' value="print">print</button>
							<button class = 'btn-group' type='button' id='maxbtn' value="max" onClick="printVal(this.id)">max</button><br/>
							<button class = 'btn-group' type='button' id='minbtn' value="min" onClick="printVal(this.id)">min</button><br/>
					</div>
				   </div>
				   

					<div style="width:60%;float:left;padding:10px;height:350px">
					   

						<button type='button' class="btn" id='submit2' name='submit2' onClick="download('test.py')" style='float:right;margin:2px;'>Export</button>
						 <button id='btn-upload' style='float:right; margin:2px;' >Import</button>
						<textarea style="width: 100%" id="filecontents" name="filecontents" placeholder="You can do python here:"></textarea>
						<button type='button' class="btn" id='submit' name='submit' style='float:right'>Execute</button>
					</div>
					

					<div style="width:20%;float:right;padding:50px 50px 50px 0px;height:250px">
						<textarea readonly style="width: 100%" id='outputArea' rows="26" cols="5"></textarea>
					</div>
				    </div>
				<div>
					

				</div>
			</form>
		</body>
		<script type="text/javascript">
		

			$(function() {
				$('#btn-upload').click(function(e) {
					e.preventDefault();
					$('#txtfiletoread').click();
				});
			});
			

			window.onload = function() {
				//Check the support for the File API support
				if (window.File && window.FileReader && window.FileList && window.Blob) {
					var fileSelected = document.getElementById('txtfiletoread');
					fileSelected.addEventListener('change', function(e) {
						//Set the extension for the file
						var fileExtension = /text.*/;
						//Get the file object
						var fileTobeRead = fileSelected.files[0];
						//Check of the extension match
						/* if (fileTobeRead.type.match(fileExtension)) { */
							//Initialize the FileReader object to read the 2file
							var fileReader = new FileReader();
							fileReader.onload = function(e) {
								var fileContents = document.getElementById('filecontents');
								console.log(fileReader.result);
								fileContents.value = fileReader.result;
							}
							fileReader.readAsText(fileTobeRead)
							

						/* } else {
							alert("Please select text file");
						} */
					}, false);
				} else {
					alert("Files are not supported");
				}
			}
			

			function download(fileName) {
				var fileContent = document.getElementById("filecontents").value;
				fileContent = fileContent.replace(/<br>/g, '\n');

				/* 	  	document.getElementById("outputArea").value = fileContent; */
				var element = document.createElement('a');
				element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(fileContent));
				element.setAttribute('download', fileName);

				element.style.display = 'none';
				document.body.appendChild(element);

				element.click();

				document.body.removeChild(element);
			}

			$(document).on("click", "#submit", function() {
				console.log("test");
				var val = encodeURIComponent($('#filecontents').val());
				console.log(val);
				if(val != ""){
					$.post("./Testing", {
						"name": val
					}, function(responseText) {
						$("#outputArea").val(responseText);
					});
				}else{
					alert("No code here");
				}
				
			});

			$(document).delegate('#filecontents', 'keydown', function(e) {
				var keyCode = e.keyCode || e.which;
				if (keyCode == 9) {
					e.preventDefault();
					var start = this.selectionStart;
					var end = this.selectionEnd;
					// set textarea value to: text before caret + tab + text after caret
					$(this).val($(this).val().substring(0, start) +
						"\t" +
						$(this).val().substring(start));
					// put caret at right position again
					this.selectionStart =
						this.selectionEnd = start + 1;
				}
			});

			$(document).on('click', '#printbtn', function() {
				var start = $('#filecontents')[0].selectionStart;
				var end = $('#filecontents')[0].selectionEnd;
				var val = 'print("")';
				$('#filecontents').val($('#filecontents').val().substring(0, start) +
					val +
					$('#filecontents').val().substring(start));
				$('#filecontents').focus();
				$('#filecontents')[0].selectionStart =
					$('#filecontents')[0].selectionEnd = start + val.length - 2;
			});

			function printVal(id) {
				var start = $('#filecontents')[0].selectionStart;
				var end = $('#filecontents')[0].selectionEnd;
				var val = (id == 'maxbtn') ? "max()" : "min()";
				$('#filecontents').val($('#filecontents').val().substring(0, start) +
					val +
					$('#filecontents').val().substring(start));
				$('#filecontents').focus();
				$('#filecontents')[0].selectionStart = $('#filecontents')[0].selectionEnd = start + val.length - 1;
			}
		</script>
	</html>