import { createRouter, createWebHistory } from 'vue-router'
import ConsultaSQL from '../components/ConsultaSQL.vue'  // Caminho correto

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: ConsultaSQL  // Rota raiz exibe seu componente
    }
    // Remova a rota '/about' se não existe AboutView.vue
  ]
})

export default router