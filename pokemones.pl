%pokemo(nombre,tipos,nivel de ataque,nivel de defensa)
pokemon(bulbasaur,[grass,poison],49,49).
pokemon(weedle,[bug,poison],45,50).
pokemon(arbok,[poison],95,69).
pokemon(nidoqueen,[poison,ground],90,40).
pokemon(charmander,[fire],52,43).
pokemon(charmeleon,[fire],64,58).
pokemon(charizar,[fire,flying],84,78).
pokemon(vulpix,[fire],41,40).
pokemon(clefairy,[fairy],45,48).
pokemon(jigglypuff,[normal,fairy],45,20).
pokemon(squirtle,[water],48,65).
pokemon(caterpie,[bug],30,35).
pokemon(metapod,[bug],52,43).
pokemon(butterfree,[bug,flying],45,50).
pokemon(pikachu,[electric],55,40).
pokemon(sandshrew,[ground],90,40).

%mostrarPokemones(L,A,B,C,D):- pokemon(_,_,_,_).
%obtiene lista con el nombre de todos los pokemones
%2a
obtenerPokemones(ListaPokemones):- findall(pokemon(A,B,C,D),pokemon(A,B,C,D),ListaPokemones).

%imprime los nombres de todos los pokemones.
%imprimirPokem

%2b
mostrarPokemonTipo([],Ps):- !.
mostrarPokemonTipo([Y|C],Lt):- !, findall(pokemon(Y1,Y2,Y3,Y4),(pokemon(Y1,Y2,Y3,Y4), member(Y,Y2)),Ps), mostrarPokemonTipo(C,T),append(Ps,T,Lt).
%mostrarPokemonTipo([Y|C],Lt):-  findall(pokemon(Y1,Y2,Y3,Y4),(pokemon(Y1,Y2,Y3,Y4), member(Y,Y2)),Ps),append(Ps,Lt,Lt), mostrarPokemonTipo(C,Lt).
%mostrarPokemonTipo([fairy,electric],Poks).

%2c
eliminaTodos(X,[X],[]):- !.
eliminaTodos(X,[X|Ys],Zs):- !,eliminaTodos(X,Ys,Zs).
eliminaTodos(X,[Y|Ys],Zs):- !,eliminaTodos(X,Ys,J), append([Y],J,Zs).
%?-eliminaTodos(pokemon(weedle,[bug,poison],45,50),[pokemon(weedle,[bug,poison],45,50),pokemon(pikachu,[electric],55,40),pokemon(weedle,[bug,poison],45,50)],L).

%2c
%Obtiene los pokemons del mismo del recibido.
pokemonTipo(pokemon(A,B,C,D),Y):- mostrarPokemonTipo(B,J),eliminaTodos(pokemon(A,B,C,D),J,Y).
%?- pokemonTipo(pokemon(sandshrew,[ground],90,40),Y).

%3
%codigo realizado
rangoAceptable(X,Y):- X - 10 < Y, Y < X + 10.

%codigo dado
similar_ataque(_,[],[]):-!.
similar_ataque(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],[pokemon(Y1,Y2,Y3,Y4)|L]):- rangoAceptable(X3,Y3),not(rangoAceptable(X4,Y4)),similar_ataque(pokemon(X1,X2,X3,X4),R,L),!.
similar_ataque(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],L):- similar_ataque(pokemon(X1,X2,X3,X4),R,L).

similar_defensa(_,[],[]):-!.
similar_defensa(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],[pokemon(Y1,Y2,Y3,Y4)|L]):-rangoAceptable(X4,Y4),not(rangoAceptable(X3,Y3)),similar_defensa(pokemon(X1,X2,X3,X4),R,L),!.
similar_defensa(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],L):- similar_defensa(pokemon(X1,X2,X3,X4),R,L).

%codigo realizado
%similar_ataque_defensa(P,K,L):- similar_ataque(P,K,T), similar_defensa(P,T,L).
similar_ataque_defensa(_,[],[]):-!.
similar_ataque_defensa(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],[pokemon(Y1,Y2,Y3,Y4)|L]):- rangoAceptable(X3,Y3),(rangoAceptable(X4,Y4)),similar_ataque_defensa(pokemon(X1,X2,X3,X4),R,L),!.
similar_ataque_defensa(pokemon(X1,X2,X3,X4),[pokemon(Y1,Y2,Y3,Y4)|R],L):- similar_ataque_defensa(pokemon(X1,X2,X3,X4),R,L).

%codigo dado
similar_caracteristica(P,L,'Defensa'):- pokemonTipo(P,Result), similar_defensa(P,Result,L).
similar_caracteristica(P,L,'AtaqueyDefensa'):- pokemonTipo(P,Result), similar_ataque_defensa(P,Result,L).

%codigo realizado
similar_caracteristica(P,L,'Ataque'):- pokemonTipo(P,Result), similar_ataque(P,Result,L).