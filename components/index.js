import Vue from 'vue';
import Router from 'vue-router';
import App from './App.vue';
import Wizard from './Wizard.vue';
import Dashboard from './Dashboard.vue';

Vue.use(Router);

const router = new Router({
	routes: [
		{
			path: '/',
			component: Dashboard
		},
		{
			path: '/wizard',
			component: Wizard
		}
	]
});

new Vue({
   render: h => h(App),
   router
}).$mount('#app');
