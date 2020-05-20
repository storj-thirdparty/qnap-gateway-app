<template>
	<div class="screen wizard">

		<div class="setup-dot"></div>
		<p class="setup-label" v-bind:class="{ 'label-active': step == 1 }">Gateway Setup</p>

		<div class="bar-1" v-bind:class="{ 'bar-active': step > 1 }"></div>

		<div class="keys-dot" v-bind:class="{ 'dot-active': step > 1 }"></div>
		<p class="keys-label" v-bind:class="{ 'label-active': step == 2 }">Save Keys</p>

		<div class="bar-2" v-bind:class="{ 'bar-active': step > 2 }"></div>

		<div class="configure-dot" v-bind:class="{ 'dot-active': step > 2 }" ></div>
		<p class="configure-label" v-bind:class="{ 'label-active': step == 3 }">Configure HBS 3</p>

		<div class="step-1" v-if="step === 1">
			<div class="signup"></div>
			<p class="signup-text">Before setting up Tardigrade S3 Gateway for QNAP, you&apos;ll need and account on Tardigrade.io</p>
			<button class="signup-button">Sign Up</button>

			<div class="background">
				<img class="logo" src="resources/img/gateway-logo.svg">

				<h1 class="title">Tardigrade S3 Gateway for QNAP</h1>
				<p class="explaination">Use Tardigrade as your storage space on HBS 3 to back up your QNAP.<br><br>To get started, enter your bucket details from Tardigrade. To learn more about buckets on Tardigrade, check out the the guide in our documentation.</p>

				<a href="#" class="docs">S3 Gateway Docs</a>

				<h2 class="bucket-details">Bucket Details</h2>

				<label class="satellite-label">Satellite</label>

				<select class="satellite form-select" v-model="satellite">
					<option default value="us-central-1.tardigrade.io">us-central-1.tardigrade.io</option>
					<option value="europe-west-1.tardigrade.io">europe-west-1.tardigrade.io</option>
					<option value="asia-east-1.tardigrade.io">asia-east-1.tardigrade.io</option>
				</select>

				<label class="api-key-label">API Key</label>
				<input type="text" class="api-key" placeholder="Enter pre-generated API key" v-model="apiKey">

				<label class="passphrase-label">Encryption Passphrase</label>
				<input type="text" class="passphrase" placeholder="Passphrase" v-model="passphrase">

				<button class="continue" v-on:click="step++" v-bind:disabled="!(isPassphraseValid && isApiKeyValid)">Continue</button>
			</div>
		</div>

		<div class="step step-2" v-if="step === 2">
			<div class="background">
				<div class="back">
					<img src="resources/img/back.png" class="icon">
					<router-link to="/">Back to Gateway Setup</router-link>
				</div>

				<h1 class="title">Save Your Keys</h1>
				<p class="explaination">Copy and paste your Access and Secret Keys in a safe place. You will need both later for configuring HSB 3 to backup your QNAP.</p>

				<label class="access-key-label">Access Key</label>
				<input type="text" class="access-key" value="35EzMZowEWjh9BJAv5okf2Sif9YV"></label>
				<button class="access-key-copy">Copy</button>

				<label class="secret-key-label">Secret Key</label>
				<input type="text" class="secret-key" value="2sHDQ6n8rPLuhBve8aaWrR3Grq55">
				<button class="secret-key-copy">Copy</button>

				<button class="continue" v-on:click="step++">Continue</button>
			</div>
		</div>

		<div class="step step-3" v-if="step === 3">
			<div class="background">
				<div class="back">
					<img src="resources/img/back.png" class="icon">
					<router-link to="/">Back to Keys</router-link>
				</div>

				<h1 class="title">Configure HBS 3</h1>

				<img src="resources/img/hbs3.png" class="hbs3">

				<p class="explaination">Next, you&apos;ll configure HBS 3 for backing up your QNAP to Tardigrade. After going through the docs, return here to manage your connection status, reconfigure Tardigrade Gateway, and see your Access and Secret keys.</p>

				<button class="guide">Configuration Guide</button>
				<!-- <a href="/" class="done">Done</a> -->
			</div>
		</div>
	</div>
</template>

<style src="./Wizard.css" scoped></style>

<script>
module.exports = {
	data: () => ({
		step: 1,

		satellite: 'us-central-1.tardigrade.io',
		apiKey: '',
		passphrase: ''
	}),
	computed: {
		isApiKeyValid() {
			return this.apiKey !== '';
		},
		isPassphraseValid() {
			return this.passphrase !== '';
		}
	}
};
</script>
