<template>
	<div class="screen wizard">

		<div class="setup-dot"></div>
		<p class="setup-label">Gateway Setup</p>

		<div class="bar-1" v-bind:class="{ 'bar-active': step > 1 }"></div>

		<div class="keys-dot" v-bind:class="{ 'dot-active': step > 1 }"></div>
		<p class="keys-label" v-bind:class="{ 'label-active': step > 1 }">Save Keys</p>

		<div class="bar-2" v-bind:class="{ 'bar-active': step > 2 }"></div>

		<div class="configure-dot"></div>
		<p class="configure-label">Configure HBS 3</p>

		<div class="step-1" v-if="step === 1">
			<div class="signup"></div>
			<p class="signup-text">Before setting up Tardigrade S3 Gateway for QNAP, you&apos;ll need and account on Tardigrade.io</p>
			<button class="signup-button">Sign Up</button>

			<div class="background">
				<img class="logo" src="resources/img/qnap-tardigrade.png">

				<h1 class="title">Tardigrade S3 Gateway for QNAP</h1>
				<p class="explaination">Use Tardigrade as your storage space on HBS 3 to back up your QNAP.<br><br>To get started, enter your bucket details from Tardigrade. To learn more about buckets on Tardigrade, check out the the guide in our documentation.</p>

				<a href="#" class="docs">S3 Gateway Docs</a>

				<h2 class="bucket-details">Bucket Details</h2>

				<label class="sattelite-label">Sattelite</label>

				<select class="sattelite" v-model="sattelite">
					<option default value="us-central-1.tardigrade.io">us-central-1.tardigrade.io</option>
					<option value="europe-west-1.tardigrade.io">europe-west-1.tardigrade.io</option>
				</select>

				<label class="api-key-label">API Key</label>
				<input type="text" class="api-key" placeholder="Enter pre-generated API key" v-model="apiKey">

				<label class="passphrase-label">Encryption Passphrase</label>
				<input type="text" class="passphrase" placeholder="Passphrase" v-model="passphrase">

				<button class="continue" v-on:click="step++">Continue</button>
			</div>
		</div>

		<div class="step step-2" v-if="step === 2">
			<div class="background">
				<div class="back">
					<img src="resources/img/back.png" class="icon">
					<p>Back to Keys</p>
				</div>

				<h1 class="title">Save Your Keys</h1>
				<p class="explaination">Copy and paste your Access and Secret Keys in a safe place. You’ll need both later for configuring HSB 3 to backup your QNAP.</p>

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
					<p>Back to Keys</p>
				</div>

				<h1 class="title">Configure HBS 3</h1>

				<img src="resources/img/hbs3.png" class="hbs3">

				<p class="explaination">Next, you&apos;ll configure HBS 3 for backing up your QNAP to Tardigrade. After going through the docs, return here to manage your connection status, reconfigure Tardigrade Gateway, and see your Access and Secret keys.</p>

				<button class="guide">Configuration Guide</button>
			</div>
		</div>
	</div>
</template>

<script>
module.exports = {
	data: () => ({
		step: 1,

		satellite: 'us-central-1.tardigrade.io',
		apiKey: '',
		passphrase: ''
	})
};
</script>

<style scoped>
.setup-dot {
	position: absolute;
	width: 20px;
	height: 20px;
	left: 422px;
	top: 99px;

	border-radius: 10px;

	background: #2683FF;
}

.setup-label {
	position: absolute;
	width: 83px;
	height: 18px;
	left: 390px;
	top: 125px;


	font-weight: bold;
	font-size: 12px;
	line-height: 148.31%;
	/* identical to box height, or 18px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #000000;
}

.bar-1 {
	position: absolute;
	width: 286px;
	height: 4px;
	left: 434px;
	top: 107px;

	background: #C5CBDB;
	border-radius: 30px;

	z-index: -100;
}

.bar-active {
	background: #2683FF !important;
}

.keys-dot {
	position: absolute;
	width: 20px;
	height: 20px;
	left: 708px;
	top: 99px;

	border-radius: 10px;

	background: #C5CBDB;
}

.keys-label {
	position: absolute;
	width: 59px;
	height: 18px;
	left: 688px;
	top: 125px;


	font-weight: normal;
	font-size: 12px;
	line-height: 148.31%;
	/* identical to box height, or 18px */

	display: flex;
	align-items: center;
	text-align: center;

	color: rgba(0, 0, 0, 0.4);
}

.bar-2 {
	position: absolute;
	width: 286px;
	height: 4px;
	left: 717px;
	top: 107px;

	background: #C5CBDB;
	border-radius: 30px;

	z-index: -100;
}

.configure-dot {
	position: absolute;
	width: 20px;
	height: 20px;
	left: 995px;
	top: 99px;

	border-radius: 10px;

	background: #C5CBDB;
}

.configure-label {
	position: absolute;
	width: 95px;
	height: 18px;
	left: 957px;
	top: 125px;


	font-weight: normal;
	font-size: 12px;
	line-height: 148.31%;
	/* identical to box height, or 18px */

	display: flex;
	align-items: center;
	text-align: center;

	color: rgba(0, 0, 0, 0.4);
}

.step-1 .signup {
	position: absolute;
	left: 252px;
	top: 180px;

	width: 936px;
	height: 72px;

	background: rgba(38, 131, 255, 0.14);
	border-radius: 6px;
}

.step-1 .signup-text {
	position: absolute;
	width: 703px;
	height: 22px;
	left: 282px;
	top: 204px;


	font-weight: normal;
	font-size: 16px;
	line-height: 135%;
	/* identical to box height, or 22px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #000000;

	opacity: 0.75;
}

.step-1 .signup-button {
	position: absolute;
	left: 1024px;
	right: 265px;
	top: 192px;
	bottom: 660px;

	/* acnt-1 */

	background: #2683FF;
	border-radius: 6px;

	width: 151px;
	height: 48px;


	font-weight: bold;
	font-size: 16px;
	line-height: 135%;

	text-align: center;

	color: #FFFFFF;
}

.step-1 .background {
	position: absolute;
	left: 252px;
	top: 270px;

	background: #FEFEFF;

	width: 936px;
	height: 565px;

	z-index: -100;
}

.step-1 .logo {
	position: absolute;
	top: 80px;
	left: 94px;

	height: 100px;
}

.step-1 .title {
	position: absolute;
	width: 288px;
	height: 68px;
	left: 96px;
	top: 214px;


	font-weight: bold;
	font-size: 24px;
	line-height: 140%;
	/* or 34px */

	display: flex;
	align-items: center;

	color: #0D1826;
}

.step-1 .explaination {
	position: absolute;
	width: 288px;
	height: 130px;
	left: 96px;
	top: 302px;


	font-weight: normal;
	font-size: 14px;
	line-height: 145%;
	/* or 20px */


	color: #384B65;
}

.step-1 .docs {
	position: absolute;
	width: 271px;
	height: 45px;
	left: 94px;
	top: 455px;


	font-weight: bold;
	font-size: 14px;
	line-height: 145%;
	/* or 20px */

	display: flex;
	align-items: center;

	color: #2683FF;
}

.step-1 .bucket-details {
	position: absolute;
	width: 298px;
	height: 22px;
	left: 480px;
	top: 80px;


	font-weight: bold;
	font-size: 22px;
	line-height: 100%;
	/* identical to box height, or 22px */

	display: flex;
	align-items: center;

	color: #0D1826;
}

.step-1 .sattelite-label {
	position: absolute;
	width: 61px;
	height: 16px;
	left: 480px;
	top: 130px;


	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.step-1 .sattelite {
	position: absolute;
	left: 480px;
	top: 154px;

	width: 360px;
	height: 52px;

	text-indent: 18px;

	background: #FFFFFF;
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	overflow: hidden;

	border-radius: 10px;


	font-weight: normal;
	font-size: 16px;

	color: #384B65;

}

.step-1 .api-key-label {
	position: absolute;
	width: 58px;
	height: 16px;
	left: 480px;
	top: 230px;


	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	align-items: center;

	color: #384B65;
}

.step-1 .api-key {
	position: absolute;
	left: 480px;
	top: 253px;

	width: 360px;
	height: 52px;

	background: #FFFFFF;
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;


	font-weight: normal;
	font-size: 16px;

	text-indent: 20px;

	color: rgba(56, 75, 101, 0.4);
}

.step-1 .passphrase-label {
	position: absolute;
	width: 174px;
	height: 16px;
	left: 481px;
	top: 342px;


	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;

	color: #384B65;
}

.step-1 .passphrase {
	position: absolute;
	left: 481px;
	top: 366px;

	width: 360px;
	height: 52px;

	background: #FFFFFF;
	border: 1px solid #E2E6E9;
	box-sizing: border-box;
	border-radius: 10px;


	font-weight: normal;
	font-size: 16px;
	line-height: 134.09%;

	text-indent: 20px;

	color: rgba(56, 75, 101, 0.4);
}

.step-1 .continue {
	position: absolute;
	left: 480px;
	top: 447px;

	width: 360px;
	height: 52px;

	background: #2683FF;
	border: 2px solid #2683FF;
	box-sizing: border-box;
	border-radius: 6px;


	font-weight: bold;
	font-size: 16px;
	line-height: 135%;

	text-align: center;

	color: #FFFFFF;
}

.step-2 .background {
	position: absolute;

	width: 936px;
	height: 625px;
	top: 180px;
	left: 252px;

	background: #FEFEFF;
	border-radius: 6px;
}

.step .back .icon {
	position: absolute;
	left: 29.5px;
	top: 26px;

	width: 6.5px;
}

.step .back p {
	position: absolute;

	left: 52.5px;
	top: 25px;


	font-weight: bold;
	font-size: 14px;
	line-height: 100%;

	color: #384B65;
}

.step-2 .title {
	position: absolute;
	width: 181px;
	height: 24px;
	left: 377px;
	top: 84px;


	font-weight: bold;
	font-size: 24px;
	line-height: 100%;
	/* identical to box height, or 24px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #0D1826;
}

.step-2 .explaination {
	position: absolute;
	width: 463px;
	height: 78px;
	left: 236px;
	top: 130px;


	font-weight: normal;
	font-size: 18px;
	line-height: 145%;
	/* or 26px */

	text-align: center;

	color: #384B65;
}

.step-2 .access-key-label {
	position: absolute;
	width: 88px;
	height: 16px;
	left: 242px;
	top: 242px;


	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #384B65;
}

.step-2 .access-key {
	position: absolute;
	left: 242px;
	top: 272px;

	width: 451px;
	height: 52px;

	background: #0C2546;
	border-radius: 10px;

	font-family: "Source Code Pro";

	font-weight: 400;
	font-size: 16px;
	line-height: 100%;

	text-indent: 17px;

	border: none;

	color: #FFFFFF;
}

.step-2 .access-key-copy {
	position: absolute;
	left: 607px;
	top: 280px;

	width: 81px;
	height: 40px;

	background: #FFFFFF;
	border-radius: 6px;


	font-weight: 500;
	font-size: 15px;
	line-height: 146.28%;


	text-align: center;

	color: #2683FF;
}

.step-2 .secret-key-label {
	position: absolute;
	width: 82px;
	height: 16px;
	left: 245px;
	top: 353px;


	font-weight: normal;
	font-size: 16px;
	line-height: 100%;
	/* identical to box height, or 16px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #384B65;
}

.step-2 .secret-key {
	position: absolute;
	left: 242px;
	top: 385px;

	width: 451px;
	height: 52px;

	background: #0C2546;
	border-radius: 10px;

	font-family: "Source Code Pro";

	font-weight: 400;
	font-size: 16px;
	line-height: 100%;

	text-indent: 20px;

	border: none;

	color: #FFFFFF;
}

.step-2 .secret-key-copy {
	position: absolute;
	left: 607px;
	top: 391px;

	width: 81px;
	height: 40px;

	background: #FFFFFF;
	border-radius: 6px;


	font-weight: 500;
	font-size: 15px;
	line-height: 146.28%;

	text-align: center;

	color: #2683FF;
}

.step-2 .continue {
	position: absolute;
	left: 365px;
	top: 497px;

	width: 205px;
	height: 48px;

	background: #2683FF;
	border-radius: 6px;


	font-weight: bold;
	font-size: 16px;
	line-height: 135%;

	text-align: center;

	color: #FFFFFF;
}

.step-3 .background {
	position: absolute;
	left: 252px;
	right: 252px;
	top: 180px;

	width: 936px;
	height: 625px;

	background: #FEFEFF;
	border-radius: 6px;
}

.step-3 .title {
	position: absolute;
	top: 84px;
	left: 371px;

	width: 195px;
	height: 24px;


	font-weight: bold;
	font-size: 24px;
	line-height: 100%;
	/* identical to box height, or 24px */

	display: flex;
	align-items: center;
	text-align: center;

	color: #0D1826;
}

.step-3 .hbs3 {
	position: absolute;
	top: 135.6px;
	left: 298.46px;

	width: 340.36px;

	box-shadow: 0 0 25px rgba(0, 0, 0, 0.2);
}

.step-3 .explaination {
	position: absolute;
	width: 707px;
	height: 78px;
	left: 114px;
	top: 356px;


	font-weight: normal;
	font-size: 18px;
	line-height: 145%;
	/* or 26px */

	text-align: center;

	color: #384B65;
}

.step-3 .guide {
	position: absolute;
	left: 366px;
	top: 485px;

	width: 205px;
	height: 48px;

	background: #2683FF;
	border: 2px solid #2683FF;
	box-sizing: border-box;
	border-radius: 6px;


	font-weight: bold;
	font-size: 16px;
	line-height: 135%;

	text-align: center;

	color: #FFFFFF;
}
</style>
