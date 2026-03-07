-- Criação do banco
CREATE DATABASE biblioteca;
USE biblioteca;

-- Categorias de leitores
CREATE TABLE categoria_leitor (
    codigo_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao_categoria VARCHAR(100) NOT NULL,
    dias_maximo_emprestimo INT NOT NULL
);

-- Leitores
CREATE TABLE leitor (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    documento_identificacao VARCHAR(50) NOT NULL,
    categoria_leitor_id INT NOT NULL,
    data_nascimento DATE NOT NULL,
    
    FOREIGN KEY (categoria_leitor_id)
    REFERENCES categoria_leitor(codigo_categoria)
);

-- Categorias de obras literárias
CREATE TABLE categoria_obra (
    codigo_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao_categoria VARCHAR(100) NOT NULL,
    taxa_diaria_atraso DECIMAL(10,2) NOT NULL
);

-- Obras literárias
CREATE TABLE obra (
    id_obra INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    isbn VARCHAR(20),
    titulo VARCHAR(300) NOT NULL,
    categoria_obra_id INT NOT NULL,
    data_publicacao DATE,
    numero_edicao INT,
    editora VARCHAR(150),
    numero_paginas INT,
    
    FOREIGN KEY (categoria_obra_id)
    REFERENCES categoria_obra(codigo_categoria)
);

-- Autores
CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL
);

-- Relação obra - autor
CREATE TABLE obra_autor (
    obra_id INT,
    autor_id INT,
    
    PRIMARY KEY (obra_id, autor_id),
    
    FOREIGN KEY (obra_id)
    REFERENCES obra(id_obra),
    
    FOREIGN KEY (autor_id)
    REFERENCES autor(id_autor)
);

-- Palavras chave
CREATE TABLE palavra_chave (
    id_palavra INT AUTO_INCREMENT PRIMARY KEY,
    palavra VARCHAR(100) NOT NULL
);

-- Relação obra - palavra chave
CREATE TABLE obra_palavra_chave (
    obra_id INT,
    palavra_id INT,
    
    PRIMARY KEY (obra_id, palavra_id),
    
    FOREIGN KEY (obra_id)
    REFERENCES obra(id_obra),
    
    FOREIGN KEY (palavra_id)
    REFERENCES palavra_chave(id_palavra)
);

-- Funcionários
CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE NOT NULL
);

-- Cópias das obras
CREATE TABLE copia_obra (
    id_copia INT AUTO_INCREMENT PRIMARY KEY,
    identificador_unico VARCHAR(50) NOT NULL,
    obra_id INT NOT NULL,
    
    FOREIGN KEY (obra_id)
    REFERENCES obra(id_obra)
);

-- Reservas
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATETIME NOT NULL,
    data_prevista_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    leitor_id INT NOT NULL,
    obra_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    
    FOREIGN KEY (leitor_id)
    REFERENCES leitor(id_leitor),
    
    FOREIGN KEY (obra_id)
    REFERENCES obra(id_obra),
    
    FOREIGN KEY (funcionario_id)
    REFERENCES funcionario(id_funcionario)
);

-- Empréstimos
CREATE TABLE emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao_real DATE,
    leitor_id INT NOT NULL,
    copia_obra_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    multa DECIMAL(10,2),
    
    FOREIGN KEY (leitor_id)
    REFERENCES leitor(id_leitor),
    
    FOREIGN KEY (copia_obra_id)
    REFERENCES copia_obra(id_copia),
    
    FOREIGN KEY (funcionario_id)
    REFERENCES funcionario(id_funcionario)
);