use oficina;

show tables;
insert into Clients( Name_, Address)
	values('Maria Silva',  'rua A 88, Centro - Morros'),
		  ('Mateus Martins',  'rua da luz 90, Centro - Morros'),
		  ('Bianca Pedro','rua 7 89,  Centro - Morros'),
		  ('Tiana Viana','avenida B 90, Centro - Morros'),
		  ('Bruna Ruas', 'rua sol 900, Centro - Morros'),
		  ('MariaRoupas', 'rua 8 111,  Centro - Morros'),
		  ('MateusDistribuidor',  'rua 14 123,  Centro - Morros');
select * from Clients;

insert into ClientPF(idClientPF,  CPF)
	values  ('1', '6789010989'),
			('2', '789062545'),
            ('3', '324567849'),
            ('4', '789056243'),
            ('5', '567890190');
            
insert into ClientPJ(idClientPJ,  CNPJ)
	values  ('6', '678901098912345'),
			('7', '78906254512345');

insert into payments (idPClient, typePayment, paymentDate)
		values  ('1','Cartão','2022-01-18'),
				('1','PIX','2022-05-21'),
                ('4','Cartão','2021-02-15'),
                ('4','Dinheiro','2022-04-03'),
                ('3','Cartão','2022-09-01');
                
select * from payments;

insert into Card (idCpayment, DebitOrCredit, cardFlag)
		values  ('1','Credit','Visa'),
				('2','Debit','MasterCard'),
                ('4','Credit','Visa'),
                ('5','Credit','Visa');

insert into PIX (idPIXPayment, PIX_number)
		values  ('3','14993214567');
            
insert into ServiceOrder (idOrderClient, idOPayment , orderStatus, Service_Order_Value)
	values  ('1','1','Confirmado', '150'),
			('2','2','Cancelado', '900'),
            ('3','3','Em Processamento', '90'),
            ('4','4','Confirmado','400'),
            ('5','5','Confirmado', '500');

insert into parts (PartCode, Pdescription, Quantity ,Pvalue)
	values 	('12345','Ponta de eixo','5','50'),
			('21345','Valvula de iginção','2','800'),
            ('23345','Correia','50','30');

insert into RequestedParts (idRequestedParts, idRP_OrtOrder, requested_quantity, DateRequest)
	values 	('1','1','2','2022-09-12'),
			('2','2','1','2022-09-01'),
            ('3','3','3','2022-09-23');

insert into services (typeService, ServiceValue, ServiceDate)
	values  ('Repair','100','2022-09-12'),
			('Repair','100','2022-08-01'),
            ('Repair','60','2022-04-23'),
            ('Revision','450','2022-12-02'),
            ('Revision','650','2022-04-15');
            
-- UPDATE services
-- SET ServiceDate = '2022-03-23'
-- WHERE idService = 3;

select * from services;

insert into providedServices (idPServices, idPSOrder)
	values  ('1','1'),
			('2','2'),
            ('3','3'),
            ('4','4'),
            ('5','5');
select * from providedServices;

insert into repairService (idRepair, Repair_description)
	values  ('1','Trocar a ponta de eixo'),
			('2','Trocar Valvula de iginção'),
            ('3','Trocar as 3 correias');



insert into revisionService (idRevision, Revision_description)
	values  ('4','Troca de oleo, alinhamento e balanceamento'),
			('5','alinhamento e balanceamento, toca de filtro e limpeza do ar condicionado');
    
insert into mechanicEmployees(idMEorder, numberOfEmployees)
	Values  ('1','3'),
			('2','4'),
            ('3','1');
            
            
insert into Employee(EmployeeCode, Ename, Speciality)
	values  ('10021','Ricardo','Motor'),
			('10011','Alan','Geral'),
			('10098','Jonatas','Eletronica');
 
 select * from clients;
 
 -- Qual mecanico é especialista em eletronica?
 select Ename as Nome, Speciality from Employee
	where Speciality = 'Eletronica';
 
 -- Quais clientes fizeram revisão no automovel?
select Name_, typeService from clients c  
		join ServiceOrder o on o.idOrderClient  = c.idClient
        join providedServices ps on ps.idPSOrder = o.idOrder
		join services s on s.idService = ps.idPServices
        join revisionService rs on rs.idRevision = ps.idPServices
		 ;

-- Quais clientes fizeram conserto em seu automovel?
select Name_, typeService from clients c  
		join ServiceOrder o on o.idOrderClient  = c.idClient
        join providedServices ps on ps.idPSOrder = o.idOrder
		join services s on s.idService = ps.idPServices
        join repairService rs on rs.idRepair = ps.idPServices
		 ;

-- Relação dos serviços prestados antes do 09/2022
select * from services
	having ServiceDate < '2022-09-01';
   
select * from revisionService;

-- Relação de serviços prestados, com sua descrição e antes de 09/2022
select s.typeService as Serviço, ((select rep.Repair_description from repairService where rep.idRepair = s.idService ) union ( select rev.Revision_description from revisionService where rev.idRevision = s.idService )) as Descrição, ServiceDate 
	from services s
	left join repairService rep on rep.idRepair = s.idService
    left join revisionService rev on rev.idRevision = s.idService
    where ServiceDate in (select ServiceDate from services having ServiceDate < '2022-09-01')
    order by s.typeService;
