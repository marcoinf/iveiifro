
-- Ministrantes
create table tbl_ministrantes(
id_ministrante	int		not null	auto_increment,
nome		varchar(200)	not null,
email		varchar(200)	not null,
cpf		varchar(11)	not null,
primary key (id_ministrante));

insert into tbl_ministrantes (id_ministrante, nome, email, cpf) values
	(1, 'João Teixeira', 'joao.teixeira@ifro.edu.br', '11111111111'),
	(2, 'Euder', 'francisco.euder@ifro.edu.br', '11111111111'),
	(3, 'Eclésio', 'xxxxx', '11111111111'),
	(4, 'Jackson', 'jackson.henrique@ifro.edu.br', '11111111111'),
	(5, 'XXXX', 'XXXX@ifro.edu.br', '11111111111'),
	(6, 'Jivago', 'jivago@ic.ufmt.br', '11111111111'),
	(7, 'Reinaldo', 'reinaldo.pereira@ifro.edu.br', '11111111111'),
	(8, 'Lucas', 'lucas.montes@ifro.edu.br', '11111111111'),
	(9, 'Marco Antonio', 'marco.andrade@ifro.edu.br', '11111111111'),
	(10, 'Douglas Legramante', 'douglas.legramante@ifro.edu.br', '11111111111'),
	(11, 'Igor', 'igor_mcb@hotmail.com', '11111111111'),
	(12, 'Erick', 'erick.weil@ifro.edu.br', '11111111111'),
	(13, 'Roberto', 'roberto.simplicio@ifro.edu.br', '11111111111'),
	(14, 'Juliano', 'juliano.naves@ifro.edu.br', '11111111111'),
	(15, 'XXXX', 'XXXX@ifro.edu.br', '11111111111');


-- Eventos
create table tbl_eventos(
id_evento		int		not null	auto_increment,
id_ministrante		int		not null,
titulo			varchar(200)	not null,
tipo			varchar(200)	not null, --usar enum: palestra, oficina, mostra de software, competicao 
carga_horaria		float		not null,
primary key (id_evento),
foreign key (id_ministrante) references tbl_ministrantes (id_ministrante)
);

insert into tbl_eventos (id_evento, id_ministrante, titulo, tipo, carga_horaria) values
	(1, 1, 'Versionamento com Git', 'oficina', 4.00),
	(2, 2, 'Plataforma Arduino', 'oficina', 4.00),
	(3, 3, 'Framework Bootstrap', 'oficina', 4.00),
	(4, 4, 'SCRUM na prática', 'oficina', 4.00),
	(5, 5, '---', 'oficina', 4.00),
	(6, 6, 'Aplicações móveis com Apache Cordova', 'oficina', 4.00),
	(7, 7, 'Excel Application', 'oficina', 4.00),
	(8, 8, 'Plataforma Raspberry Pi', 'oficina', 4.00),
	(9, 9, 'Criando layouts para web com Flexbox', 'oficina', 4.00),
	(10, 10, 'Modelagem 3D com SketchUp', 'oficina', 4.00),
	(11, 11, 'Programação Mobile com Xamarin', 'oficina', 4.00),
	(12, 12, 'Scratch', 'oficina', 4.00),
	(13, 13, 'Plataforma Arduino', 'oficina', 4.00),
	(14, 14, 'Introdução ao Python', 'oficina', 4.00),
	(15, 15, '---', 'oficina', 4.00);

-- Quantidade de vagas
create table tbl_qtd_vagas(
id_evento	int		not null,
qtd_disponiveis	int		not null,
qtd_preenchidas	int		not null,
status		varchar(30)	not null default 'aberto',
primary key (id_evento),
foreign key (id_evento) references tbl_eventos (id_evento)
);

insert into tbl_qtd_vagas(id_evento, qtd_disponiveis, qtd_preenchidas) values
	(1, 20), (2, 20), (3, 20), (4, 30), (5, 20), (6, 40), (7, 20), (8, 20), (9, 20), (10, 20), (11, 40), (12, 20), (13, 20), (14, 20),  (15, 20);



-- Vagas por eventos
create table tbl_vagas_eventos(
id_vaga		int		not null,
id_evento	int		not null,
id_inscricao	int,
dt_hr_inscricao	datetime,
dt_hr_presenca	datetime,
primary key (id_vaga, id_evento),
foreign key (id_evento) references tbl_eventos (id_evento),
foreign key (id_inscricao) referecens tbl_inscricoes (id_inscricao)
);

insert into tbl_vagas_eventos (id_vaga, id_evento) values 
	(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1), (20, 1),


-- Inscrições
create table tbl_inscricoes(
id_inscricao	int		not null	auto_increment,
nome		varchar(200)	not null,
email		varchar(200)	not null,
cpf		varchar(11)	not null,
alun_monitor	char(1)		default 'N', --Para posterior emissão de certificados
primary key (id_inscricao));
-- Além de selecionar a oficina (tbl_vagas_eventos) serão inseridas linhas para as palestras e mostra de software nas tbl_vagas_eventos.



-- Os certificados serão gerados a partir da tbl_vagas_eventos e tbl_inscricoes (para inscritos, inclusive monitores) e da tbl_eventos (palestrantes, etc..)
-- Garantir que cada aluno só se inscreva em uma única oficinas
-- Certificados (criar uma trigger para gera-los)
create table tbl_certificados_participantes(
id_certificado_participante	varchar(200) 	not null,
id_inscricao			int		not null,
id_vaga_evento			int 		not null,
primary key (id_certificado_participante),
foreign key (id_inscricao) references tbl_inscricoes (id_inscricao),
foreign key (id_vaga_evento) references tbl_vagas_eventos (id_vaga_evento),
);

create table tbl_certificados_ministrantes(
id_certificado_ministrante	varchar(200)	not null,
id_ministrante			int		not null,
id_evento			int 		not null,
primary key (id_certificado_ministrante),
foreign key (id_evento) references tbl_eventos (id_evento),
foreign key (id_ministrante) references tbl_ministrantes (id_minnistrante)
);


