
#=
Fuege in dieses Template deine Loesungscodes ein.
Wichtig 1: Die Datei gemaess der Namensrichtlinien benennen.
Wichtig 2: Bitte nur die Funktionen ausprogrammieren und keine Funktionsaufrufe vornehmen.
=#

# Die Bearbeitung der Aufgaben ist in einem Testskript erfolgt, der Code wurde von
# diesen Testskript kopiert und hier in diesem Skript eingefügt und anschließend
# wurden die jeweiligen "erwähnenswerten" commits auf Github gepushed. (Deshalb
# die eher geringen Zeitabstände der commits.)

### Beispiel 1:

function greatest(x::Vector{T}, k::Integer = 1) :: Vector{T} where {T <: Real}
    # Überprüfung des Parameters k
    if k <= 0
        error("Fehler: k muss größer als 0 sein.")
    elseif k > length(x)
        error("Fehler: k darf nicht größer als die Länge von x sein.")
    end

    # Die k größten Elemente herausfinden
    sorted_x = sort(x, rev = true)  # Sortiere absteigend
    largest_k = sorted_x[1:k]        # Nehme die ersten k Elemente

    # Jetzt wollen wir die Reihenfolge des Auftretens im Originalvektor erhalten
    result = T[]  # Leerer Vektor vom Typ T

    for elem in x
        if elem in largest_k
            push!(result, elem)
        end
    end

    return result
end


### Beispiel 2

function nearestindex(x::Vector{T}, y::Real) :: Int where T <: Real
    # Berechne die absoluten Differenzen
    diffs = abs.(x .- y)
    
    # Finde den kleinsten Wert
    min_diff = minimum(diffs)
    
    # Finde alle Indizes mit der minimalen Differenz
    closest_indices = findall(x -> abs(x - y) == min_diff, x)
    
    # Wähle bitte zufällig einen Index, wenn mehrere vorhanden sind
    return closest_indices[rand(1:length(closest_indices))]
end


### Beispiel 3

function swap!(x::Vector{T}, i::Integer, j::Integer) where T <: Real
    # Tausch der Elemente an den Indizes i und j
    temp = x[i]
    x[i] = x[j]
    x[j] = temp
end

function bubblesort!(x::Vector{T}; rev::Bool = false) where T <: Real
    n = length(x)
    
    # Bubble-Sort-Algorithmus
    for i in 1:n-1
        for j in 1:n-i
            if (rev && x[j] < x[j+1]) || (!rev && x[j] > x[j+1])
                swap!(x, j, j+1)
            end
        end
    end
end


### Beispiel 4

function canonicaltour(x::Vector{T}) where T <: Integer
    # Überprüfen, ob x eine gültige Permutation der Zahlen von 1 bis n ist
    if sort(x) != 1:length(x)
        throw(ArgumentError("Die Eingabe ist keine gültige Permutation der Zahlen 1 bis $(length(x))."))
    end
    
    # Die Position von Stadt 1 finden und die Permutation so verschieben, dass Stadt 1 an erster Stelle steht
    start_index = findfirst(x .== 1)
    x = circshift(x, -start_index + 1)

    # Umkehren, wenn die Reihenfolge nicht gegen den Uhrzeigersinn ist
    # Erstellen der Permutation sowohl im Uhrzeigersinn als auch gegen den Uhrzeigersinn
    x_clockwise = x
    x_counterclockwise = reverse(x)

    # Die kanonische Form ist die lexikografisch kleinere der beiden Permutationen
    # Dazu erstellen wir alle zyklischen Verschiebungen und wählen die kleinste. (dazu eignet sich circshift)
    permutations = [circshift(x_clockwise, i) for i in 0:length(x)-1]
    permutations_rev = [circshift(x_counterclockwise, i) for i in 0:length(x)-1]

    # Finde die lexikografisch kleinste Permutation (im Uhrzeigersinn oder gegen den Uhrzeigersinn)
    min_perm = minimum(permutations)
    min_perm_rev = minimum(permutations_rev)
    
    return min(min_perm, min_perm_rev)
end


### Beispiel 5

function distance(x::Vector{T}, y::Vector{T}; p::Real = 2) where T
    # a) Längenvergleich
    if length(x) != length(y)
        throw(ArgumentError("Die Vektoren x und y müssen die gleiche Länge haben."))
    end
    
    # b) p > 0
    if p <= 0
        throw(ArgumentError("Der Wert von p muss größer als 0 sein."))
    end
    
    # c) Berechnung der p-Distanz
    dist = sum(abs(x[i] - y[i])^p for i in 1:length(x))^(1/p)
    
    # d) Rückgabe der p-Distanz
    return dist
end

