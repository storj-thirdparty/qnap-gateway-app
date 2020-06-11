<template>
	<div class="container-lg">

		<div class="screen wizard">

			<div class="row">
					<div class="wizard-progress">
						<div class="wizard-progress-track"></div>

						<div class="wizard-progress-step" :class="{ 'is-active': step === 1, 'is-complete': step > 1 }">
							<p class="wizard-progress-label" :class="{ 'label-active': step === 1 }">Gateway Setup</p>
						</div>

						<div class="wizard-progress-step" :class="{ 'is-active': step === 2, 'is-complete': step > 2 }">
							<p class="wizard-progress-label" :class="{ 'label-active': step === 2 }">Save Keys</p>
						</div>

						<div class="wizard-progress-step" :class="{ 'is-active': step === 3 }">
							<p class="wizard-progress-label" :class="{ 'label-active': step === 3 }">Configure HBS 3</p>
						</div>
					</div>
			</div>

			<div class="step-1" v-if="step === 1">

				<div class="signup">
					<div class="row">
						<div class="col-sm-12 col-md-9">
							<p class="signup-text">Before setting up Tardigrade S3 Gateway for QNAP, you&apos;ll need and account on Tardigrade.io</p>
						</div>
						<div class="col-sm-12 col-md-3 text-md-right">
							<button class="btn signup-button" href="https://tardigrade.io/satellites/" target="blank">Sign Up</button>
						</div>
					</div>
				</div>

				<div class="background">
					<div class="row">

						<div class="col-sm-12 col-md-6">
							<img class="logo" src="resources/img/gateway-logo.svg">
							<h1 class="title">Tardigrade S3 Gateway for QNAP</h1>
							<p class="explaination">Use Tardigrade as your storage space on HBS 3 to back up your QNAP.<br><br>To get started, enter your bucket details from Tardigrade. To learn more about buckets on Tardigrade, check out the the guide in our documentation.</p>
							<a href="https://documentation.tardigrade.io/how-tos/backup-on-qnap" class="docs mb-5" target="blank">S3 Gateway Docs</a>
						</div>

						<div class="col-sm-12 col-md-6">
							<h2 class="bucket-details mb-4">Bucket Details</h2>

							<label class="satellite-label">Satellite</label>
							<select class="satellite custom-select custom-select-lg mb-3" v-model="satellite">
								<option default value="us-central-1.tardigrade.io">us-central-1.tardigrade.io</option>
								<option value="europe-west-1.tardigrade.io">europe-west-1.tardigrade.io</option>
								<option value="asia-east-1.tardigrade.io">asia-east-1.tardigrade.io</option>
							</select>

							<label class="api-key-label">API Key</label>
							<input type="text" class="api-key form-control mb-3" placeholder="Enter pre-generated API key" v-model="apiKey">

							<label class="passphrase-label">Encryption Passphrase</label>
							<input type="text" class="passphrase form-control mb-3" placeholder="Passphrase" v-model="passphrase">

							<button class="btn btn-block continue" id="btn" @click="firstStepContinue" :disabled="!(isPassphraseValid && isApiKeyValid)">Continue<i class="lds-ring dnone" id="loader"><div></div><div></div><div></div><div></div></i></button>
						</div>

					</div>
				</div>

				<!--<div class="toast-wrapper">
					<div id="api-key-toast" role="alert" aria-live="assertive" aria-atomic="true" class="toast" data-autohide="true">
					  <div class="toast-header">
					    <img src="resources/img/icon-error.svg" class="rounded mr-2" alt="Error icon">
					    <p class="toast-title mr-auto">API Key/Passphrase Failed. </p>
							<button type="button" class="ml-3 mb-0 close" data-dismiss="toast" aria-label="Close">
								<img src="resources/img/icon-close.svg" class="icon-close" alt="Close icon">
							</button>
					  </div>
						<div class="toast-body">
							<p>Sign in to your selected Satellite at Tardigrade.io to verify your bucket details and retry.</p>
						</div>
					</div>
				</div>-->

			</div>

			<div class="step step-2" v-if="step === 2">

				<div class="background">

					<div class="row">
						<div class="col">
							<div class="back">
								<img src="resources/img/back.png" class="icon">
								<router-link to="/">Back to Gateway Setup</router-link>
							</div>
						</div>
					</div>

					<div class="row justify-content-center">
						<div class="col-sm-8 col-md-7 col-lg-6">

							<h1 class="title text-center">Save Your Keys</h1>
							<p class="explanation text-center mb-4">Copy and paste your Access and Secret Keys in a safe place. You will need both later for configuring HSB 3 to backup your QNAP.</p>

							<label class="access-key-label">Access Key</label>

							<div class="input-group mb-4">
				        <input type="text" class="access-key form-control" v-model="accessKey">
								<div class="input-group-prepend">
				          <button class="access-key-copy" @click.stop.prevent="copyAccessKey">Copy</button>
				        </div>
				      </div>

							<label class="secret-key-label">Secret Key</label>

							<div class="input-group mb-4">
				        <input type="text" class="secret-key form-control" v-model="secretKey">
								<div class="input-group-prepend">
				          <button class="secret-key-copy" @click.stop.prevent="copySecretKey">Copy</button>
				        </div>
				      </div>

							<div class="row justify-content-center">
								<div class="col-md-6">
									<button class="continue btn btn-block mb-5" @click="step++">Continue</button>
								</div>
							</div>

						</div>
					</div>

				</div>

				<!--<div class="toast-wrapper">
					<div id="access-key-toast" role="alert" aria-live="assertive" aria-atomic="true" class="toast" data-autohide="true">
					  <div class="toast-header">
					    <img src="resources/img/icon-success.svg" class="rounded mr-2" alt="Success icon">
					    <p class="toast-title mr-auto">Access Key Copied to Clipboard</p>
							<button type="button" class="ml-3 mb-0 close" data-dismiss="toast" aria-label="Close">
								<img src="resources/img/icon-close.svg" class="icon-close" alt="Close icon">
							</button>
					  </div>
					</div>

					<div id="secret-key-toast" role="alert" aria-live="assertive" aria-atomic="true" class="toast" data-autohide="true">
						<div class="toast-header">
							<img src="resources/img/icon-success.svg" class="rounded mr-2" alt="Success icon">
							<p class="toast-title mr-auto">Secret Key Copied to Clipboard</p>
							<button type="button" class="ml-3 mb-0 close" data-dismiss="toast" aria-label="Close">
								<img src="resources/img/icon-close.svg" class="icon-close" alt="Close icon">
							</button>
						</div>
					</div>
				</div>-->

			</div>

			<div class="step step-3" v-if="step === 3">
				<div class="background">

					<div class="row">
						<div class="col">
							<div class="back">
								<img src="resources/img/back.png" class="icon">
								<router-link to="/">Back to Keys</router-link>
							</div>
						</div>
					</div>

					<div class="row justify-content-center text-center">
						<div class="col-sm-8">

							<h1 class="title">Configure HBS 3</h1>
							<img src="resources/img/hbs3.png" class="hbs3">
							<p class="explanation mb-4">Next, you&apos;ll configure HBS 3 for backing up your QNAP to Tardigrade. After going through the docs, return here to manage your connection status, reconfigure Tardigrade Gateway, and see your Access and Secret keys.</p>

							<div class="row justify-content-center">
								<div class="col-md-6">
									<a class="guide btn btn-block mb-4 mt-2" href="https://documentation.tardigrade.io/how-tos/backup-on-qnap#configure-hbs-3-with-tardigrade-as-a-storage-space" target="_blank">Configuration Guide</a>
								</div>
							</div>

							<a class="done mb-4" @click="save">Done</a>

						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</template>

<style src="./Wizard.css" scoped></style>

<script>
import callEndpoint from './callEndpoint';

export default {
	data: () => ({
		step: 1,

		satellite: 'us-central-1.tardigrade.io',
		apiKey: '',
		passphrase: '',
		accessKey: '',
		secretKey: '',
	}),
	computed: {
		isApiKeyValid() {
			return this.apiKey !== '';
		},
		isPassphraseValid() {
			return this.passphrase !== '';
		}
	},
	methods: {
		async save() {
			// await callEndpoint('wizard-save', {
			// 	satellite: this.satellite,
			// 	apiKey: this.apiKey,
			// 	passphrase: this.passphrase
			// });

			this.$router.push({ path: '/' });
		},

		async firstStepContinue() {
			document.getElementById("btn").classList.add("button-opacity");
			document.getElementById("loader").classList.remove("dnone");
			await callEndpoint('wizard-save', {
				satellite: this.satellite,
				apiKey: this.apiKey,
				passphrase: this.passphrase
			});

			const {
				accessKey,
				secretKey,
			} = await callEndpoint('dashboard-info');

			this.accessKey = accessKey;
			this.secretKey = secretKey;
			this.step++;
		},

		copyAccessKey () {
	          let accessKeyToCopy = document.querySelector('.access-key')
	          accessKeyToCopy.setAttribute('type', 'text')
	          accessKeyToCopy.select()

	          try {
	            var successful = document.execCommand('copy');
	            var msg = successful ? 'successful' : 'unsuccessful';
	          } catch (err) {
	            alert("Oops, unable to copy");
	          }
        },

        copySecretKey () {
	          let secretKeyToCopy = document.querySelector('.secret-key')
	          secretKeyToCopy.setAttribute('type', 'text')
	          secretKeyToCopy.select()

	          try {
	            var successful = document.execCommand('copy');
	            var msg = successful ? 'successful' : 'unsuccessful';
	          } catch (err) {
	            alert("Oops, unable to copy");
	          }
        	},
		}
};
</script>
