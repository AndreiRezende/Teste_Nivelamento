<template>
    <div class="container">
    <header class="app-header">
      <img src="@/assets/logoic.jpg" alt="Intuitive Care" class="logo">
      <h1 class="app-title">Intuitive Care</h1>
    </header>
      <div class="dashboard">
        <div class="query-panel">
          <h1>Consulta SQL<br>Maiores Despesas</h1>
          <form @submit.prevent="buscarDados">
            <div class="form-group">
              <label for="descricao">Descrição da demonstração contábil:</label>
              <input v-model="descricao" type="text" id="descricao" required>
            </div>
            
            <div class="form-group">
              <label for="data">Data:</label>
              <input v-model="data" type="date" id="data" required>
            </div>
            
            <button type="submit">Buscar</button>
          </form>
        </div>
  
        <div class="results-panel">
          <h1>Operadoras de Plano de Saúde Ativas</h1>
          
          <div v-if="submitted && dados.length === 0" class="no-results">
            Nenhum resultado encontrado
          </div>
          
          <table v-if="dados.length > 0">
            <thead>
              <tr>
                <th v-for="(valor, chave) in dados[0]" :key="chave">{{ formatarCabecalho(chave) }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(linha, index) in dados" :key="index">
                <td v-for="(valor, chave) in linha" :key="chave">{{ valor }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        descricao: '',
        data: '',
        dados: [],
        submitted: false
      };
    },
    methods: {
      async buscarDados() {
        this.submitted = true;
        
        try {
          const response = await axios.get('http://localhost:8000/operadora/', {
            params: {
              descricao: this.descricao,
              data: this.data
            }
          });
          this.dados = response.data || [];
        } catch (error) {
          console.error("Erro:", error);
        }
      },
      formatarCabecalho(chave) {
        const cabecalhos = {
          'razao_social': 'Razão Social',
          'registro_ans': 'Registro ANS',
          'descricao': 'Descrição',
          'diferenca': 'Despesa (R$)'
        };
        return cabecalhos[chave] || chave;
      }
    }
  };
  </script>
  
  <style>
  .container {
    padding: 20px;
    max-width: 95%;
    margin: 0 auto;
  }
  
  .dashboard {
    display: flex;
    gap: 20px;
    min-height: 80vh;
  }
  .query-panel, .results-panel {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .query-panel {
    flex: 1;
    min-width: 350px;
  }
  
  .results-panel {
    flex: 2;
    min-width: 600px;
    overflow-y: auto;
    max-height: 80vh;
  }
  
  form {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
  
  button {
    padding: 10px;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color:#5dc560;
    border: 2px solid white;
    transform: scale(1.1);
  }
  
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
  }
  
  th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }
  
  th {
    background-color: #f2f2f2;
  }
  
  .no-results {
    padding: 20px;
    text-align: center;
    color: #665;
  }
  h1 {
    font-family: "Arial", sans-serif;
    color: rgb(31, 29, 29);
    font-weight: 200;
    line-height: 1.2;
    font-size: 32px;
  }
  .app-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eaeaea;
}

.logo {
  height: 50px;
  width: auto;
}

.app-title {
  font-family: 'Segoe UI', Arial, sans-serif;
  font-size: 28px;
  font-weight: 600;
  color: rgb(171, 96, 245);
  margin: 0;
}

.query-panel h2,
.results-panel h2 {
  font-size: 24px;
  margin-bottom: 20px;
  color: #333;
}

</style>