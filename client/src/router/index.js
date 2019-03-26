import Vue from 'vue';
import Router from 'vue-router';
import Locations from '@/components/Locations';
import Menu from '@/components/Menu';
import Filters from '@/components/Filters';
import Account from '@/components/Account';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/locations',
      name: 'Locations',
      component: Locations,
    },
      {
        path: '/account/:email',
        name: 'account',
        component: Account,
      },
    {
      path: '/filters',
      name: 'Filters',
      component: Filters,
    },
    {
      path: '/menu',
      name: 'Menu',
      component: Menu,
    },
  ],
  mode: 'history',

});
