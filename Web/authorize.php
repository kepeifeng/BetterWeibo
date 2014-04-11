<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>正在跳转...</title>
		<link rel="stylesheet" href="css/auth.css" />
		<script>
			
			var QueryString = function () {
			  // This function is anonymous, is executed immediately and 
			  // the return value is assigned to QueryString!
			  var query_string = {};
			  var query = window.location.search.substring(1);
			  var vars = query.split("&");
			  for (var i=0;i<vars.length;i++) {
			    var pair = vars[i].split("=");
			    	// If first entry with this name
			    if (typeof query_string[pair[0]] === "undefined") {
			      query_string[pair[0]] = pair[1];
			    	// If second entry with this name
			    } else if (typeof query_string[pair[0]] === "string") {
			      var arr = [ query_string[pair[0]], pair[1] ];
			      query_string[pair[0]] = arr;
			    	// If third or later entry with this name
			    } else {
			      query_string[pair[0]].push(pair[1]);
			    }
			  } 
			    return query_string;
			} ();
			
			window.location.href = "pinwheel://"+ QueryString.code;
			window.close();
			
			
		</script>
		
		
	</head>
	<body>
	
	<div id="content">
		<p><img src="stamp.png" alt="Bebo" /></p>
		<h2>您现在可以关闭本页面了</h2>
		<h3 id="countdownMessage">（将在10秒后尝试自动关闭）</h3>
	</div>
	
	</body>
</html>
