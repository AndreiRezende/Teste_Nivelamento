<template>
    <div class="container">
      <h1 class="title">Consulta SQL</h1>
      
      <div class="form-container">
        <form @submit.prevent="buscarDados" class="search-form">
          <div class="form-group">
            <label for="descricao" class="form-label">Descrição:</label>
            <input v-model="descricao" type="text" id="descricao" class="form-input" required />
          </div>
          
          <div class="form-group">
            <label for="data" class="form-label">Data:</label>
            <input v-model="data" type="date" id="data" class="form-input" required />
          </div>
          
          <button type="submit" class="search-button">Buscar</button>
        </form>
      </div>
  
      <div v-if="submitted && dados.length === 0" class="no-results">
        Nenhum resultado encontrado para os filtros aplicados.
      </div>
  
      <div v-if="dados.length > 0" class="table-container">
        <table class="results-table">
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
                const params = {
                descricao: this.descricao,
                data: this.data
                };

                const response = await axios.get('http://localhost:8000/operadora/', { params });

                this.dados = response.data || [];
                
            } catch (error) {
                console.error("[ERRO COMPLETO]", {
                message: error.message,
                config: error.config,
                response: error.response?.data
                });
            }
        },
        formatarCabecalho(chave) {
            const cabecalhos = {
            'razao_social': 'Razão Social',
            'registro_ans': 'Registro ANS',
            'descricao': 'Descrição',
            'diferenca': 'Diferença (R$)'
            };
            return cabecalhos[chave] || chave;
        }
    }
  };
  </script>
  
  <style>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
    padding: 1rem;
    max-width: 800px;
    margin: 0 auto;
    padding-top: 2rem;
  }
  
  .title {
    margin-bottom: 1.5rem;
    color: #2c3e50;
    font-size: 2rem;
  }
  
  .form-container {
    width: 100%;
    max-width: 500px;
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
  }
  
  .search-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }
  
  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .form-label {
    font-weight: 500;
    color: #495057;
  }
  
  .form-input {
    padding: 0.6rem;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 1rem;
    transition: border-color 0.3s;
  }
  
  .search-button {
    padding: 0.6rem;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-top: 0.5rem;
  }
  
  .no-results {
    text-align: center;
    padding: 1rem;
    background-color: #f8d7da;
    color: #721c24;
    border-radius: 4px;
    width: 100%;
    max-width: 500px;
    margin: 0.5rem 0;
  }
  
  .table-container {
    width: 100%;
    overflow-x: auto;
    margin-top: 1rem;
  }
  
  .results-table {
    width: 100%;
    border-collapse: collapse;
    box-shadow: 0 2px 3px rgba(0,0,0,0.1);
  }
  
  th, td {
    border: 1px solid #ddd;
    padding: 0.75rem;
    text-align: left;
  }
  
  th {
    background-color: #f2f2f2;
    font-weight: bold;
  }
  
  tr:nth-child(even) {
    background-color: #f9f9f9;
  }
  
  tr:hover {
    background-color: #f1f1f1;
  }
  </style>