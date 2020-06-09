<template>

	<div class="container-lg">

		<div class="row">
			<div class="col-md">

				<div class="status-box">

					<div class="row">

						<div class="col-4">
							<h2 class="status-title">Status</h2>
						</div>

						<div class="col-8 text-right">

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

							<!-- Status when gateway is stopped -->

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


							<!-- Status when gateway is restarting -->

							<div class="dropdown status-dropdown status-restarting" v-if="status === 'restarting'">
								<div class="status-light status-light-restarting">
									<img src="resources/img/icon-restarting.svg" alt="Restarting icon" class="icon-restarting">
								</div>
								<a class="dropdown-toggle " href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									Restarting...
								</a>
							</div>

						</div>

					</div>

				</div>

				<div class="gateway-box">

					<div class="row">
						<div class="col">
							<h2 class="gateway-title">Gateway Config</h2>
						</div>
					</div>

					<div class="row mt-4">
						<div class="col">
							<p class="access-key-label">Access Key</p>
						</div>
						<div class="col text-right">
							<p class="access-key-show" v-on:click="accessKeyShown = true" v-if="accessKeyShown === false"><span>Show</span> <img src="resources/img/show.png"></p>
							<p class="access-key-hide" v-on:click="accessKeyShown = false" v-if="accessKeyShown === true"><span>Hide</span> <img src="resources/img/hide.png"></p>
						</div>
					</div>

					<div class="row">
						<div class="col">
							<input v-bind:type="accessKeyInputType" disabled class="access-key" v-model="accessKey">
						</div>
					</div>

					<div class="row mt-4">
						<div class="col">
							<p class="secret-key-label">Secret Key</p>
						</div>
						<div class="col text-right">
							<p class="secret-key-show" v-on:click="secretKeyShown = true" v-if="secretKeyShown === false"><span>Show</span> <img src="resources/img/show.png"></p>
							<p class="secret-key-hide" v-on:click="secretKeyShown = false" v-if="secretKeyShown === true"><span>Hide</span> <img src="resources/img/hide.png"></p>
						</div>
					</div>

					<div class="row">
						<div class="col">
							<input v-bind:type="secretKeyInputType" disabled class="secret-key" v-model="secretKey">
						</div>
					</div>

				</div>

			</div>

			<div class="col-md">

				<div class="bucket-box mb-5">

					<div class="row">

						<div class="col-8">
							<h2 class="bucket-title">Bucket Details</h2>
						</div>

						<div class="col-4 text-right">
							<div class="reconfigure">
								<a href="" data-toggle="modal" data-target="#reconfigureModal">Reconfigure</a>
							</div>
						</div>

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
											<router-link to="/wizard"><button type="button" class="btn btn-lg btn-primary btn-block" data-dismiss="modal">Yes, Reconfigure</button></router-link>
										</div>
									</div>
					      </div>
					    </div>
					  </div>
					</div>

					<div class="row mt-4">
						<div class="col">
							<p class="satellite-label">Satellite</p>
							<input class="satellite" type="text" disabled v-model="satellite">
						</div>
					</div>

					<div class="row mt-4">
						<div class="col">
							<p class="api-key-label">API Key</p>
							<input class="api-key" type="password" disabled value="****************">
						</div>
					</div>

					<div class="row mt-4">
						<div class="col">
							<p class="passphrase-label">Encryption Passphrase</p>
							<input class="passphrase" type="password" disabled value="****************">
						</div>
					</div>

				</div>

			</div>

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
				action: 'run'
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
