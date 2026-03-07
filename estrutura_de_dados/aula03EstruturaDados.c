#include <stdio.h>
#include <stdlib.h>


// 1) - O que e um TAD e qual a caracteristica fundamental? 
// Resposta: TAD e um tipo de dado que agrupa dados e operacoes sobre esses dados.

// 2) - Quais as vantagens de se programar com TADs?
// Resposta: 
// 1. Encapsulamento: esconde os detalhes internos dos dados.
// 2. Reutilizacao: o TAD pode ser usado em varios projetos.
// 3. Manutencao: da pra mudar a implementacao sem quebrar o resto do codigo.
// 4. Legibilidade: o codigo fica mais claro e organizado.
// 5. Menos erros: o acesso controlado evita estados invalidos nos dados.

// 3) TAD Conta Bancaria (implementacao com struct)

typedef struct {
    int numero;
    char titular[100];
    float saldo;
} ContaBancaria;

void inicializar(ContaBancaria *conta, int numero, const char *titular) {
    conta->numero = numero;
    int i = 0;
    while (titular[i] != '\0' && i < 99) {
        conta->titular[i] = titular[i];
        i++;
    }
    conta->titular[i] = '\0';
    conta->saldo = 0.0f;
    printf("Conta %d criada com sucesso para %s.\n", conta->numero, conta->titular);
}

void depositar(ContaBancaria *conta, float valor) {
    if (valor <= 0) {
        printf("Erro: valor de deposito deve ser positivo.\n");
        return;
    }
    conta->saldo += valor;
    printf("Deposito de R$ %.2f realizado. Saldo atual: R$ %.2f\n", valor, conta->saldo);
}


void sacar(ContaBancaria *conta, float valor) {
    if (valor <= 0) {
        printf("Erro: valor de saque deve ser positivo.\n");
        return;
    }
    if (valor > conta->saldo) {
        printf("Erro: saldo insuficiente. Saldo atual: R$ %.2f\n", conta->saldo);
        return;
    }
    conta->saldo -= valor;
    printf("Saque de R$ %.2f realizado. Saldo atual: R$ %.2f\n", valor, conta->saldo);
}


void imprimirSaldo(const ContaBancaria *conta) {
    printf("=================================\n");
    printf("  Conta: %d\n", conta->numero);
    printf("  Titular: %s\n", conta->titular);
    printf("  Saldo: R$ %.2f\n", conta->saldo);
    printf("=================================\n");
}

// 4) Criar uma nova conta bancaria usando alocacao dinamica de memoria


ContaBancaria* criarConta(int numero, const char *titular) {
    ContaBancaria *novaConta = (ContaBancaria*) malloc(sizeof(ContaBancaria));

    if (novaConta == NULL) {
        printf("Erro: falha na alocacao de memoria.\n");
        return NULL;
    }

    inicializar(novaConta, numero, titular);
    return novaConta;
}

int main() {
    printf(">>> QUESTAO 3: Conta com alocacao estatica <<<\n\n");

    ContaBancaria conta1;
    inicializar(&conta1, 1001, "Caio");
    depositar(&conta1, 1500.00);
    sacar(&conta1, 300.00);
    sacar(&conta1, 2000.00); // erro: saldo insuficiente
    imprimirSaldo(&conta1);

    printf("\n>>> QUESTAO 4: Conta com alocacao dinamica (malloc) <<<\n\n");

    ContaBancaria *conta2 = criarConta(2002, "Maria");
    if (conta2 != NULL) {
        depositar(conta2, 5000.00);
        sacar(conta2, 1250.50);
        imprimirSaldo(conta2);

        free(conta2);
        printf("\nMemoria da conta 2002 liberada com sucesso.\n");
    }

    return 0;
}
