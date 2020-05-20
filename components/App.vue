<template>
	<div>
		<nav>
			<div class="screen">
				<router-link to="/">
					<img src="resources/img/tardigrade.png" class="tardigrade">
				</router-link>

				<span class="spacer"></span>
				<p class="gateway">S3 Gateway</p>

				<a href="#" class="docs">S3 Gateway Docs</a>
				<a href="#" class="login">Tardigrade Login</a>
			</div>
		</nav>

		<router-view></router-view>
	</div>
</template>

<style src="./App.css"></style>
