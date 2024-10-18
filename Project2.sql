-- Média de Preço de Cada Estado por Tipo de Imóvel --

with cte as
    (select substring_index(Bairro,', ',-1) as Capital, Preco, Tipo
     from descricaoimovel di inner join informacoescustosimovel ici
     on di.ID = ici.ID)

select Capital, Tipo, round(avg(Preco),3) as Média_Preço
from cte
group by Capital, Tipo
having Capital in ('Rio de Janeiro', 'São Paulo', 'Belo Horizonte')
order by Capital desc, Tipo, Média_Preço desc;


-- Itens mais e menos comuns do Sudeste --

with cte as
    (select count(Item) as Contagem, tipo, item,
     row_number() over (partition by Tipo order by count(item) desc) as 'Rows_Num'
     from expansaoitensimovel eii inner join descricaoimovel di on eii.ID = di.ID
     where item > "."
     group by tipo, item
     having Tipo != 'Not Informed'
     order by tipo asc, Contagem desc),

    cte2 as (select distinct tipo, max(Rows_Num) over (partition by Tipo) as Maximized from cte)

select cte.Tipo, Item, Contagem
from cte inner join cte2 on cte.Tipo = cte2.tipo
where (cte.Rows_Num between 0 and 5) or (cte.Rows_Num between Maximized-4 and Maximized)
order by cte.Tipo asc, Contagem desc;


-- Tipo de Imóveis mais comuns por Estados --

with cte as
    (select substring_index(Bairro,",",-1) as Estado, Tipo
     from descricaoimovel
     di inner join informacoescustosimovel ici on di.ID = ici.ID)

select *, count(Tipo) as contagem from cte
where Estado not in ('Not Informed','')
group by Estado, Tipo
limit 9 offset 0;

-- Média de Preço por Mobiliado vs Não Mobiliado --

select Tipo, Mobiliagem, round(avg(Preco),3) as Média_Preço
from especificacoesinternasimovel eii inner join informacoescustosimovel
iei on eii.ID = iei.ID inner join descricaoimovel di on eii.ID = di.ID
where Tipo != 'Not Informed'
group by Tipo, Mobiliagem
having round(avg(Preco),3) > 0
order by Tipo asc, Média_Preço desc;

-- Média de Preço baseado na Publicação dos Imóveis --

select Capital, Posted, round(avg(Preço),3) as Average_Price, count(*) as Contagem
from
    (select cast(Preco as FLOAT ) as Preço,
     date_format(date_sub(curdate(),interval PublicacaoDias + 1 day),'%Y-%m') as Posted,
     substring_index(Bairro,', ',-1) as Capital
     from descricaoimovel di inner join informacoescustosimovel ici
     on di.ID = ici.ID) as subquery
group by Capital, Posted
having Capital in ('Rio de Janeiro', 'São Paulo', 'Belo Horizonte')
order by Capital desc, Posted desc;

-- Número de Imóvel por Bairros --

with cte as
    (select substring_index(Bairro,",",-1) as Cidade, Bairro, count(*) as contagem
     from descricaoimovel
     group by Cidade, Bairro
     order by Cidade asc, contagem desc)

select Cidade, Bairro, contagem, Ranking
from (select *, rank() over (partition by Cidade order by contagem desc) as Ranking from cte) as cte2
where Ranking <=5 and contagem > 55
order by Cidade desc;

-- Bairros com Maiores Custo Beneficio R$/m^2 --

with cte as
    (select distinct substring_index(Bairro,', ',-1) as Capital, Bairro,
    round(avg((Preco * 1000/Area)),2) as 'Propoção(R$/m²)'
    from descricaoimovel di inner join informacoescustosimovel ici
    on di.ID = ici.ID inner join especificacoesinternasimovel eii on di.ID = eii.ID
    group by Capital, Bairro
    having Capital not in ('Not Informed','') and Capital in ('Rio de Janeiro', 'São Paulo', 'Belo Horizonte')
    order by Capital desc, `Propoção(R$/m²)` desc)

select * from
    (select *, row_number() over (partition by Capital order by `Propoção(R$/m²)` desc) as Row_Num from cte) as SubQ
where Row_Num <= 10;

-- Ruas do Sudeste com maior Venda de Imóveis --

with cte as
    (select count(*) as Contagem, Logradouro, substring_index(Bairro,', ',-1) as Capital, Bairro
     from descricaoimovel
     group by substring_index(Bairro,', ',-1), Bairro, Logradouro
     having Capital != 'Not Informed' and Capital in ('Rio de Janeiro', 'São Paulo', 'Belo Horizonte')
     order by contagem desc)

select Capital, Bairro, Logradouro, Contagem from
    (select *, row_number() over (partition by Capital order by Contagem desc) as Rows_Numbers
     from cte
     order by Capital desc, Contagem desc)
     as SubQuery
where Rows_Numbers <= 10;

-- Padrão Semanal de Publicação de Imóveis --

select count(*) as Contagem,
date_format(date_sub(curdate(),interval PublicacaoDias day),'%W') as Week_Day
from descricaoimovel
where PublicacaoDias between 1 and 29
group by Week_Day
order by Contagem desc;

-- Preço Médio de Condomínios por Bairro --

with cte as
    (select substring_index(Bairro,', ',-1) as Capital, Bairro, round(avg(Condominio),2) as 'Condomínio(R$)',
     count(*) as Contagem, row_number() over (partition by substring_index(Bairro,',',-1) order by count(*) desc) as Ordering
     from descricaoimovel di inner join informacoescustosimovel ici
     on di.ID = ici.ID
     where Condominio > 0
     group by Bairro, Logradouro
     having Bairro not in (',','Not Informed'))

select Capital, Bairro, round(avg(`Condomínio(R$)`),2) as `Condomínio(R$)`, floor(avg(Contagem)) as Count
from cte
where Ordering <= 15 and Capital in ('Rio de Janeiro', 'São Paulo', 'Belo Horizonte')
group by Capital, Bairro
order by Capital desc, `Condomínio(R$)` desc;

