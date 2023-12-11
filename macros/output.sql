{% macro output(model) %}

    {%
        set results = run_query(
            ref(model)
        )
     %}

     {% do results.print_table() %}

{% endmacro %}
