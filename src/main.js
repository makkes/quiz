import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import { VueHammer } from 'vue2-hammer';
import './registerServiceWorker'

Vue.use(VueHammer);
Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
