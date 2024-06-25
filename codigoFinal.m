function resultados = busqueda_lineal_matriz()
    % Inicializar variables
    tamano_inicial = 100;
    incremento = 100;
    num_resultados = 50;
    resultados = cell(num_resultados, 1);
    
    % Inicializar arrays para la tabla
    tamano_array_tabla = zeros(num_resultados, 1);
    tiempo_inicio_tabla = zeros(num_resultados, 1);
    tiempo_fin_tabla = zeros(num_resultados, 1);
    tiempo_total_tabla = zeros(num_resultados, 1);
    iteraciones_tabla = zeros(num_resultados, 1);
    
    % Generar 50 resultados con tamaños de array crecientes
    for i = 1:num_resultados
        tamano_array = tamano_inicial + (i - 1) * incremento;
        array = randi([0, 100], 1, tamano_array);
        numero_a_buscar = randi([0, 100], 1, 1);
        
        [resultado, inicio, fin, iteraciones] = busqueda_lineal(array, numero_a_buscar);
        
        if resultado ~= -1
            resultado_str = sprintf('El numero %d se encuentra en la posicion %d.', numero_a_buscar, resultado);
        else
            resultado_str = sprintf('El numero %d no se encuentra en el array.', numero_a_buscar);
        end
        
        resultado_str = sprintf('%s\nTamano del array: %d', resultado_str, tamano_array);
        resultado_str = sprintf('%s\nTiempo de inicio: %f', resultado_str, inicio);
        resultado_str = sprintf('%s\nTiempo de fin: %f', resultado_str, fin);
        resultado_str = sprintf('%s\nTiempo total: %f segundos', resultado_str, fin - inicio);
        resultado_str = sprintf('%s\nNumero de iteraciones: %d', resultado_str, iteraciones);
        resultados{i} = resultado_str;
        
        % Guardar datos en arrays para la tabla
        tamano_array_tabla(i) = tamano_array;
        tiempo_inicio_tabla(i) = inicio;
        tiempo_fin_tabla(i) = fin;
        tiempo_total_tabla(i) = fin - inicio;
        iteraciones_tabla(i) = iteraciones;
    end
    
    % Crear la tabla de resultados
    T = table(tamano_array_tabla, tiempo_inicio_tabla, tiempo_fin_tabla, tiempo_total_tabla, iteraciones_tabla, ...
        'VariableNames', {'TamanoArray', 'TiempoInicio', 'TiempoFin', 'TiempoTotal', 'Iteraciones'});
    
    % Imprimir la tabla de resultados
    disp('Tabla de Resultados:');
    disp(T);
    
    % Graficar iteraciones vs TamanoArray
    figure;
    plot(tamano_array_tabla, iteraciones_tabla, '-o');
    xlabel('Tamano del Array');
    ylabel('Numero de Iteraciones');
    title('Iteraciones vs Tamano del Array');
    
    % Graficar iteraciones vs TiempoFin con gráfico de barras
    figure;
    tiempo_fin_indices = 1:num_resultados; % Usar índices en lugar de tiempo_fin_tabla
    bar(tiempo_fin_indices, iteraciones_tabla);
    xlabel('Índice del Resultado');
    ylabel('Numero de Iteraciones');
    title('Iteraciones vs Tiempo de Fin');
    set(gca, 'XTick', tiempo_fin_indices); % Asegurar que todas las barras se etiqueten correctamente
    
    % Imprimir los 50 resultados
    for idx = 1:num_resultados
        fprintf('Resultado %d:\n', idx);
        fprintf('%s\n', resultados{idx});
        fprintf('\n%s\n\n', repmat('-', 1, 40));
    end
end

function [indice, inicio, fin, iteraciones] = busqueda_lineal(array, numero)
    inicio = tic; % Iniciar temporizador
    iteraciones = 0;
    indice = -1;
    
    for i = 1:length(array)
        iteraciones = iteraciones + 1;
        if array(i) == numero
            indice = i;
            break;
        end
    end
    
    fin = toc(inicio); % Terminar temporizador
end
