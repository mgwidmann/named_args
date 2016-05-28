defmodule NamedArgs do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [def: 2, defp: 2]
      import unquote(__MODULE__)
    end
  end

  defmacro def(definition = {_fn_name, _meta, params}, [do: content]) do
    quote do
      Kernel.def(unquote(definition)) do
        merge_defaults(unquote(params))
        unquote(content)
      end
    end
  end

  defmacro defp(definition = {_fn_name, _meta, params}, [do: content]) do
    quote do
      Kernel.defp(unquote(definition)) do
        merge_defaults(unquote(params))
        unquote(content)
      end
    end
  end

  defmacro merge_defaults([]), do: nil
  defmacro merge_defaults([{:\\, _, [var_name, defaults]} | params]) when is_list(defaults) do
    quote do
      var!(unquote(var_name)) = Keyword.merge(unquote(defaults), var!(unquote(var_name)))
      merge_defaults(unquote(params))
    end
  end
  defmacro merge_defaults([{:\\, _, [var_name, {:%{}, _, defaults}]} | params]) do
    quote do
      var!(unquote(var_name)) = Map.merge(Enum.into(unquote(defaults), %{}), var!(unquote(var_name)))
      merge_defaults(unquote(params))
    end
  end
  defmacro merge_defaults([_no_default | params]) do
    quote do
      merge_defaults(unquote(params))
    end
  end
end
