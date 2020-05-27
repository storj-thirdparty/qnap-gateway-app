<template>
	<div class="screen">
		<div class="status-box">
			<h2 class="status-title">Status</h2>

			<!-- Status when gateway is connected -->

			<div class="dropdown status-dropdown" v-if="status === 'connected'">
				<div class="status-light status-light-connected"></div>
			  <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Connected
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#" v-on:click="stop">Stop Gateway</a>
			    <a class="dropdown-item" href="#" v-on:click="restart">Restart Gateway</a>
			  </div>
			</div>

			<!-- Example of status when gateway is stopped -->

			<div class="dropdown status-dropdown" v-if="status === 'stopped'">
				<div class="status-light status-light-stopped"></div>
			  <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Stopped
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#" v-on:click="start">Start Gateway</a>
			    <a class="dropdown-item disabled" href="#">Restart Gateway</a>
			  </div>
			</div>


			<!-- Example of status when gateway is restarting -->

			<div class="dropdown status-dropdown status-restarting" v-if="status === 'restarting'">
				<div class="status-light status-light-restarting">
					<img src="resources/img/icon-restarting.svg" alt="Restarting icon" class="icon-restarting">
				</div>
			  <a class="dropdown-toggle " href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Restarting...
			  </a>
			</div>

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
				<a href="" data-toggle="modal" data-target="#reconfigureModal">Reconfigure</a>
			</div>

			<!-- Reconfigure Modal -->
			<div class="modal fade" id="reconfigureModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title mx-auto" id="staticBackdropLabel">Are You Sure?</h5>
			      </div>
			      <div class="modal-body">
			        <p>Reconfiguring will reset Tardigrade S3 Gateway. Your information here will be removed, but this will not delete data already backed up to Tardigrade.</p>
			      </div>
			      <div class="modal-footer">
							<div class="row">
								<div class="col-6">
									<button type="button" class="btn btn-lg btn-outline-primary btn-block" data-dismiss="modal">Cancel</button>
								</div>
								<div class="col-6">
									<button type="button" class="btn btn-lg btn-primary btn-block">Yes, Reconfigure</button>
								</div>
							</div>
			      </div>
			    </div>
			  </div>
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
import callEndpoint from './callEndpoint';

export default {
	data: () => ({
		status: 'connected',

		accessKey: '',
		accessKeyShown: true,

		secretKey: '',
		secretKeyShown: false,

		satellite: ''
	}),
	computed: {
		accessKeyInputType() {
			return this.accessKeyShown ? 'text' : 'password';
		},

		secretKeyInputType() {
			return this.secretKeyShown ? 'text' : 'password';
		}
	},
	methods: {
		async stop() {
			await callEndpoint('gateway-action', {
				action: 'stop'
			});

			await this.getDashboardInfo();
		},
		async start() {
			await callEndpoint('gateway-action', {
				action: 'start'
			});

			await this.getDashboardInfo();
		},
		async restart() {
			await callEndpoint('gateway-action', {
				action: 'restart'
			});

			await this.getDashboardInfo();
		},
		async getDashboardInfo() {
			const {
				accessKey,
				secretKey,
				satellite,
				status
			} = await callEndpoint('dashboard-info');

			if(typeof accessKey !== 'string' || accessKey === '') {
				 this.$router.push({ path: '/wizard' });
			}

			this.accessKey = accessKey;
			this.secretKey = secretKey;
			this.satellite = satellite;

			if(typeof status === 'string') {
				this.status = status;
			}
		}
	},
	async created() {
		await this.getDashboardInfo();
	}
};
</script>
