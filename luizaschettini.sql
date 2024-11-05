CREATE DATABASE reserva_quartos;
\c reserva_quartos;

CREATE TABLE hospedes (
    id_hospede SERIAL PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    documento VARCHAR(15) NOT NULL
);

SELECT * FROM hospedes;

CREATE TABLE quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    capacidade INT NOT NULL,
    preco_diaria DECIMAL(10,2) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

SELECT * FROM quartos;

CREATE TABLE reservas(
    id_reserva SERIAL PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
);

SELECT * FROM reservas;

INSERT INTO hospedes (nome, email, telefone, endereco, documento)
VALUES 
('Luiza Schettini', 'luiza@gmail,com', '(11) 99999-9999', 'Rua do Beija Flor, 123', '42131313133'),
('Gabriel Perin', 'biel@gmail.com', '(11)99777-7777', 'Rua dos Sabiás, 20', '43423434343'),
('Julia Emmerich', 'julia@gmail.com', '(11)99888-8888', 'Rua do Beija Flor, 123', '42101010101'),
('Lucas Perin', 'lucas@gmail.com', '(11)99666-6666', 'Rua dos Sabiás, 20', '43252525255');

SELECT * FROM hospedes;

INSERT INTO quartos (numero, capacidade, preco_diaria, disponivel)
VALUES
('101', 2, 120.00, TRUE),
('102', 2, 120.00, TRUE),
('103', 3, 180.00, TRUE),
('104', 4, 240.00, TRUE),
('105', 5, 120.00, FALSE);

SELECT * FROM quartos;

INSERT INTO reservas (id_hospede, id_quarto, data_inicio, data_fim)
VALUES
(1, 1, '2024-11-01', '2024-11-05'),
(2, 2, '2024-10-30', '2024-11-03'),
(3, 3, '2024-11-01', '2024-11-05'),
(4, 4, '2024-11-01', NULL);

SELECT * FROM reservas;

/* hospedes que já finalizaram suas estadias */

SELECT 
h.nome,
q.numero AS numero_quarto,
r.data_inicio, 
r.data_fim

FROM hospedes h

JOIN
reservas r ON h.id_hospede = r.id_hospede

JOIN
quartos q ON r.id_quarto = q.id_quarto

WHERE r.data_fim IS NOT NULL;


/* lista todos os hospedes*/

SELECT 
h.nome,
q.numero AS numero_quarto,
r.data_inicio,
r.data_fim

FROM hospedes h

JOIN
reservas r ON h.id_hospede = r.id_hospede

JOIN 
quartos q ON r.id_quarto = q.id_quarto;

/*lista todos os quartos que ainda nao forma reservados*/

SELECT 
q.numero,
q.capacidade,
q.preco_diaria

FROM quartos q

LEFT JOIN 
reservas r ON q.id_quarto = r.id_quarto

WHERE q.disponivel IS FALSE;


