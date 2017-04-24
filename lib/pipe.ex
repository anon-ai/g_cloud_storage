defmodule GCloudStorage.Pipe do
  defmacro __using__(_) do
    quote do
      import GCloudStorage.Pipe
    end
  end
  defmacro pipe_matching(test, pipes) do
    do_pipe_matching((quote do: expr), (quote do: unquote(test) = expr), pipes)
  end
  defmacro pipe_matching(expr, test, pipes) do
    do_pipe_matching(expr, test, pipes)
  end
  defp do_pipe_matching(expr, test, pipes) do
    [{h,_}|t] = Macro.unpipe(pipes)
    Enum.reduce t, h, &(reduce_matching &1, &2, expr, test)
  end
  defp reduce_matching({x, pos}, acc, expr, test) do
    quote do
      case unquote(acc) do
        unquote(test) -> unquote(Macro.pipe(expr, x, pos))
        acc -> acc
      end
    end
  end
end
