% Programa ejercicio identificar nacionalidad.
% Comentario
% Se identifica con 3 a 4 características.

:- dynamic relacion/3, relacion/4.

% Base de Conocimiento.

nacionalidad(chileno):- 
    continente(sudaca),
    idioma(espanol),
    jerga(hueon).

nacionalidad(colombiano):-
    continente(sudaca),
    idioma(espanol),
    jerga(vaina),
    calor(mucho).

nacionalidad(brasilero):- 
    continente(sudaca),
    idioma(portugues),
    futbol(campeon).

nacionalidad(pendejo):-
    continente(europeo).

% Definición de características.

continente(X) :- ask_opciones(continente, X, [sudaca, europeo]).
idioma(X) :- ask_opciones(idioma, X, [espanol, portugues]).
jerga(X) :- ask_opciones(jerga, X, [hueon, vaina]).
calor(X) :- ask(calor, X).
futbol(X) :- ask(futbol, X).

% Implementación de ask y ask_opciones

ask(Atributo, Valor) :-
    (relacion(si, Atributo, Valor) ->
        true
    ;
    relacion(no, Atributo, Valor) ->
        fail
    ;
    format('~w? (si/no) ', [Atributo]),
    read(R),
    (R == si -> asserta(relacion(si, Atributo, Valor)); asserta(relacion(no, Atributo, Valor)), fail)
    ).

ask_opciones(Atributo, Valor, Opciones) :-
    (relacion(si, Atributo, Valor) ->
        true
    ;
    relacion(si, Atributo, R), member(R, Opciones) ->
        R == Valor
    ;
    format('~w? ~w ', [Atributo, Opciones]),
    read(R),
    (member(R, Opciones) -> asserta(relacion(si, Atributo, R)), R == Valor ; writeln('Opción desconocida'), ask_opciones(Atributo, Valor, Opciones))
    ).

% Identificar de acuerdo a 3 a 4 características.

identificar :-
    retractall(relacion(_, _, _)),
    retractall(relacion(_, _, _, _)),
    (nacionalidad(X) -> write('La nacionalidad es: '), write(X); writeln('No se pudo identificar la nacionalidad')).
