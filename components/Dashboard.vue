<template>
	<div class="screen">
		<modal v-show="isModalVisible" @close="closeModal"/>
		<div class="status-box">
			<h2 class="status-title">Status</h2>
			<div id="status-light" class="statusicons"></div>
			<i class="fa fa-repeat dnone statusicons" aria-hidden="true" id="restart-icon"></i>
			<div class="dnone statusicons" id="status-red"></div>

			<div class="dropdown status-text">
			    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span id="first">Connected</span>
			    <span class="caret"></span></button>
			    <ul class="dropdown-menu">
			    <li id="start" class="dnone"><a id="Start Gateway" v-on:click.prevent="startstop" >Start Gateway</a></li>
			      <li id="stop"><a id="Stop Gateway"  v-on:click.prevent="startstop">Stop Gateway</a></li>
			      <li id="restart"><a id="Restart Gateway"  v-on:click.prevent="startstop">Restart Gateway</a></li>
			      <li id="restart1" class="dnone"><a id="Restart Gateway" class="rs">Restart Gateway</a></li>
   				 </ul>
			</div>
		</div>


		<div class="gateway-box">
			<h2 class="gateway-title">Gateway Config</h2>

			<p class="access-key-label">Access Key</p>

			<p class="access-key-show" v-on:click="accessKeyShown = true" v-if="accessKeyShown === false">Show <img src="../../resources/img/show.png"></p>
			<p class="access-key-hide" v-on:click="accessKeyShown = false" v-if="accessKeyShown === true">Hide <img src="../../resources/img/hide.png"></p>

			<input v-bind:type="accessKeyInputType" disabled class="access-key" v-model="accessKey">

			<p class="secret-key-label">Secret Key</p>

			<p class="secret-key-show" v-on:click="secretKeyShown = true" v-if="secretKeyShown === false">Show <img src="../../resources/img/show.png"></p>
			<p class="secret-key-hide" v-on:click="secretKeyShown = false" v-if="secretKeyShown === true">Hide <img src="../../resources/img/hide.png"></p>

			<input v-bind:type="secretKeyInputType" disabled class="secret-key" v-model="secretKey">
		</div>

		<div class="bucket-box">
			<div class="reconfigure">
				<a @click="showModal">Reconfigure</a>
			</div>

			<h2 class="bucket-title">Bucket Details</h2>

			<p class="satellite-label">Satellite</p>
			<input class="satellite" type="text" disabled v-model="satellite">

			<p class="api-key-label">API Key</p>
			<input class="api-key" type="password" disabled value="****************">

			<p class="passphrase-label">Encryption Passphrase</p>
			<input class="passphrase" type="password" disabled value="****************">
		</div>
	</div>
</template>

<script>
  import modal from '../components/modal.vue';

  export default {
    name: 'app',
    components: {
      modal,
    },
    data () {
      return {
        isModalVisible: false,
        accessKey: '',
		accessKeyShown: true,

		secretKey: '',
		secretKeyShown: false,

		satellite: '',
		selected: "",
      };
    },
    methods: {
      showModal() {
        this.isModalVisible = true;
      },
      closeModal() {
        this.isModalVisible = false;
      },
      fetchData(){
	     axios.get(this.baseUrl + '../../config.json').then(response => {
	        this.satellite = response.data.Satellite;
	        this.accessKey = response.data.AccessKey;
	        this.secretKey = response.data.SecretKey;
	     })
	 },


	  startstop: function (event) {
            this.status(event.currentTarget.id);
        },

	 async status(status) {
	 	
	 	const {data} = await axios.post('config.php', {
			status: status
		});

		if(data == "Restarting" || data == "Stopped" || data == "Conneted"){
			document.getElementById("first").textContent = data;
	 	}else{
	 		data = "Stopped";
	 		document.getElementById("first").textContent = data;
	 	}

	 	if (data == "Conneted") {

	 		document.getElementById("status-red").classList.add("dnone");
	 		document.getElementById("restart-icon").classList.add("dnone");
	 		document.getElementById("status-light").classList.remove("dnone");

	 		document.getElementById("start").classList.add("dnone");
	 		document.getElementById("stop").classList.remove("dnone");

	 		document.getElementById("restart").classList.remove("dnone");
	 		document.getElementById("restart1").classList.add("dnone");
	 		

	 	}else if(data == "Stopped"){

	 		document.getElementById("restart-icon").classList.add("dnone");
	 		document.getElementById("status-light").classList.add("dnone");
	 		document.getElementById("status-red").classList.remove("dnone");

	 		document.getElementById("stop").classList.add("dnone");
	 		document.getElementById("start").classList.remove("dnone");

	 		document.getElementById("restart").classList.add("dnone");
	 		document.getElementById("restart1").classList.remove("dnone");

	 	}else if(data == "Restarting"){
	 		document.getElementById("status-light").classList.add("dnone");
	 		document.getElementById("status-red").classList.add("dnone");
	 		document.getElementById("restart-icon").classList.remove("dnone");

	 	}

	 }

    },
    computed: {
		accessKeyInputType() {
			return this.accessKeyShown ? 'text' : 'password';
		},

		secretKeyInputType() {
			return this.secretKeyShown ? 'text' : 'password';
		},

	},

	 created () {
        // Fetch Data
    	this.fetchData();
    	this.status("Cheking Process");
	 },
  };
</script>

<style scoped>
.status-box {
	position: absolute;
	left: 204px;
	top: 120px;

	width: 456px;
	height: 120px;

	background: #FEFEFF;
	border-radius: 6px;
}

.status-title {
	position: absolute;
	left: 71px;
	top: 57px;

	font-weight: bold;
	font-size: 18px;
	line-height: 100%;

	display: flex;
	align-items: center;

	color: #0D1826;
}

#status-light {
	position: absolute;
	left: 249px;
	top: 60px;

	width: 12px;
	height: 12px;

	border-radius: 6px;

	background: #37FDCE;
}

#status-red {
	position: absolute;
	left: 249px;
	top: 60px;

	width: 12px;
	height: 12px;

	border-radius: 6px;

	background: red;
}

#restart-icon{
	position: absolute;
    left: 249px;
    top: 58px;
    color: lightgray;
}

.status-text {
	position: absolute;
	/*left: 269px;*/
	left: 262px;
	top: 58px;

	width: 125px;
	height: 16px;

	display: flex;
	align-items: center;

	color: rgba(0, 0, 0, 0.7);
	background: white;
    border: none;
}

.gateway-box {
	position: absolute;
	left: 204px;
	top: 274px;

	width: 456px;
	height: 344px;

	background: #FEFEFF;
	border-radius: 6px;
}

.gateway-title {
	position: absolute;
	left: 71px;
	top: 50px;

	width: 298px;
	height: 18px;

	font-weight: bold;
	font-size: 18px;
	line-height: 100%;

	display: flex;
	align-items: center;

	color: #0D1826;
}

.access-key-label {
	position: absolute;
	left: 71px;
	top: 98px;

	width: 88px;
	height: 16px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.access-key-show, .access-key-hide {
	position: absolute;
	left: 315px;
	top: 96px;

	width: 69px;
	height: 14px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 14px;
	line-height: 100%;
	/* identical to box height, or 14px */

	display: flex;
	align-items: center;

	color: #9BA4B2;

	cursor: pointer;
}

.access-key-show img {
	position: absolute;
	left: 46px;
	top: 0px;

	width: 20px;
}

.access-key-hide img {
	position: absolute;
	left: 46px;
	top: -3px;

	width: 20px;
}

.access-key {
	position: absolute;

	left: 72px;
	top: 122px;

	width: 312px;
	height: 52px;

	background: rgba(226, 229, 233, 0.4);
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;

	font-family: "Source Code Pro";
	font-style: normal;
	font-weight: 500;
	font-size: 16px;
	line-height: 100%;

	color: rgba(56, 75, 101, 0.75);

	text-indent: 20px;
}

.secret-key-label {
	position: absolute;
	left: 71px;
	top: 202px;

	width: 82px;
	height: 16px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.secret-key {
	position: absolute;
	left: 72px;
	top: 226px;

	width: 312px;
	height: 52px;

	background: rgba(226, 229, 233, 0.4);
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;

	font-family: "Source Code Pro";
	font-style: normal;
	font-weight: 500;
	font-size: 16px;
	line-height: 100%;

	color: rgba(56, 75, 101, 0.75);

	text-indent: 20px;
}

.secret-key-show, .secret-key-hide {
	position: absolute;
	left: 315px;
	top: 201px;

	width: 69px;
	height: 14px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 14px;
	line-height: 100%;
	/* identical to box height, or 14px */

	display: flex;
	align-items: center;

	color: #9BA4B2;

	cursor: pointer;
}

.secret-key-show img {
	position: absolute;
	left: 46px;
	top: 0px;

	width: 20px;
}

.secret-key-hide img {
	position: absolute;
	left: 46px;
	top: -3px;

	width: 20px;
}

.bucket-box {
	position: absolute;
	left: 684px;
	top: 120px;

	width: 552px;
	height: 498px;

	background: #FEFEFF;
	border-radius: 6px;
}

.reconfigure {
	position: absolute;
	left: 352px;
	top: 52px;

	width: 127px;
	height: 14px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 14px;
	line-height: 100%;
	/* identical to box height, or 14px */

	display: flex;
	align-items: center;
	cursor: pointer;
}

.reconfigure > * {
	width: 127px;
	text-align: right !important;
	color: #2683FF !important;
}

.bucket-title {
	position: absolute;
	left: 72px;
	top: 71px;

	width: 298px;
	height: 18px;

	font-weight: bold;
	font-size: 18px;
	line-height: 100%;
	/* identical to box height, or 18px */

	display: flex;
	align-items: center;

	color: #0D1826;
}

.satellite-label {
	position: absolute;
	left: 72px;
	top: 119px;

	width: 61px;
	height: 16px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.satellite {
	position: absolute;
	left: 72px;
	top: 143px;

	width: 407px;
	height: 52px;

	background: rgba(226, 229, 233, 0.4);
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 134.09%;

	text-indent: 20px;

	color: rgba(56, 75, 101, 0.75);
}

.api-key-label {
	position: absolute;
	left: 72px;
	top: 223px;

	width: 58px;
	height: 16px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.api-key {
	position: absolute;
	left: 72px;
	top: 247px;

	width: 407px;
	height: 52px;

	background: rgba(226, 229, 233, 0.4);
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 134.09%;

	text-indent: 20px;

	color: rgba(56, 75, 101, 0.75);
}

.passphrase-label {
	position: absolute;
	left: 73px;
	top: 331px;

	width: 174px;
	height: 16px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.passphrase {
	position: absolute;
	left: 73px;
	top: 355px;

	width: 407px;
	height: 52px;

	background: rgba(226, 229, 233, 0.4);
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;

	font-family: Inter;
	font-style: normal;
	font-weight: normal;
	font-size: 16px;
	line-height: 134.09%;

	text-indent: 20px;

	color: rgba(56, 75, 101, 0.75);
}

.dnone{
	display: none;
}

.dropdown-toggle{
	border: none;
}

.dropdown-toggle:hover{
	background-color: white ! important;
}

.dropdown-toggle:focus{
	background-color: white ! important;
}

.dropdown-menu{
	top: 147%;
    left: -24px;
}

.rs{
	color: lightgrey;
	cursor: not-allowed;
}

.caret{
	position: relative;
    left: 10px;
    bottom: 2px;
}
</style>
