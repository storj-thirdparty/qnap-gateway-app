<template>
	<div class="screen">
		<div class="status-box">
			<h2 class="status-title">Status</h2>

			<div class="dropdown status-dropdown">
				<div class="status-light status-light-connected"></div>
			  <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Connected
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#">Stop Gateway</a>
			    <a class="dropdown-item" href="#">Restart Gateway</a>
			  </div>
			</div>

			<!-- Example of status when gateway is stopped -->

			<!-- <div class="dropdown status-dropdown">
				<div class="status-light status-light-stopped"></div>
			  <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Stopped
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#">Start Gateway</a>
			    <a class="dropdown-item disabled" href="#">Restart Gateway</a>
			  </div>
			</div> -->

		</div>

		<div class="gateway-box">
			<h2 class="gateway-title">Gateway Config</h2>

			<p class="access-key-label">Access Key</p>

			<p class="access-key-show" v-on:click="accessKeyShown = true" v-if="accessKeyShown === false">Show <img src="resources/img/show.png"></p>
			<p class="access-key-hide" v-on:click="accessKeyShown = false" v-if="accessKeyShown === true">Hide <img src="resources/img/hide.png"></p>

			<input v-bind:type="accessKeyInputType" disabled class="access-key" v-model="accessKey">

			<p class="secret-key-label">Secret Key</p>

			<p class="secret-key-show" v-on:click="secretKeyShown = true" v-if="secretKeyShown === false">Show <img src="resources/img/show.png"></p>
			<p class="secret-key-hide" v-on:click="secretKeyShown = false" v-if="secretKeyShown === true">Hide <img src="resources/img/hide.png"></p>

			<input v-bind:type="secretKeyInputType" disabled class="secret-key" v-model="secretKey">
		</div>

		<div class="bucket-box">
			<div class="reconfigure">
				<router-link to="/wizard">Reconfigure</router-link>
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

<style src="./Dashboard.css" scoped></style>

<script>
module.exports = {
	data: () => ({
		accessKey: '2sHDQ6n8rPLuhBve8aaWrR3Grq55',
		accessKeyShown: true,

		secretKey: '2sHDQ6n8rPLuhBve8aaWrR3Grq55',
		secretKeyShown: false,

		satellite: 'us-central-1.tardigrade.io'
	}),
	computed: {
		accessKeyInputType() {
			return this.accessKeyShown ? 'text' : 'password';
		},

		secretKeyInputType() {
			return this.secretKeyShown ? 'text' : 'password';
		}
	}
};
</script>
