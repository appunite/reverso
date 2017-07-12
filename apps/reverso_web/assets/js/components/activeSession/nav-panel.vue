<template>	
	<div id="menu" style="width: 100%;"> 

		<ul>
			<li>
				Reverso.co
			</li>

			<li style="float: right;">  
				<div class="dropdown">
					<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"> User
						<span class="caret"></span></button>
						<ul class="dropdown-menu dropdown-menu-right">
							<li><a href="#">Account</a></li>
							<li><a href="#">Log Out</a></li>
						</ul>
					</div>
				</li>
			</ul>

		</div>
	</template>

	<script>
		export default {

			data () {
				return {
					
				}

			}
			

		}
	</script>

	<style scoped>
		#menu {
			background:  #040a42;
			padding: 18px 16px;	
		}

		#menu ul {
			list-style-type: none;
			display: inline;
		}

		#menu li {
			float: left;
			color: white;
			background:  #040a42;
		}

		#menu button {
			border: 0px;
			color: white;
			background:  #040a42;
		}

		.dropdown-menu {
			border-radius: 0 !important; 
		}

		.dropdown-menu li {
			background: white !important;
			color: black;
			padding: 10px;
		}

	</style>