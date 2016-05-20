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

  defmacro merge_defaults([]), do: nil
  defmacro merge_defaults([{:\\, _, [{var_name, _, nil}, defaults]} | pararms]) when is_list(defaults) do
    quote do
      var!(opts) = Keyword.merge(unquote(defaults), var!(opts))
    end
  end
  defmacro merge_defaults([_no_default | params]) do
    quote do
      merge_defaults(unquote(params))
    end
  end
end
