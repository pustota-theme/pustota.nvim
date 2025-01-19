defmodule DemoMac do
  defmacro macro_add(a, b) do
    quote do
      unquote(a) + unquote(b)
    end
  end
end

defprotocol DemoProtocol do
  @doc "Returns a string representation of a data structure."
  def to_string(data)
end

defimpl DemoProtocol, for: Integer do
  def to_string(i), do: "Integer(#{IO.puts 1})"
end

defimpl DemoProtocol, for: BitString do
  def to_string(str), do: "String: #{str}"
end

defmodule DemoStruct do
  defstruct value: 0, label: ""

  def new(value, label \\ "No label") do
    %__MODULE__{value: value, label: label}
  end

  def label_upcase(%__MODULE__{label: label} = s) do
    %{s | label: String.upcase(label)}
  end
end

defmodule DemoGenServer do
  use GenServer

  def start_link(init_value) do
    GenServer.start_link(__MODULE__, init_value, name: __MODULE__)
  end

  @impl true
  def init(init_value) do
    {:ok, init_value}
  end

  @impl true
  def handle_call({:increment, amount}, _from, state) do
    {:reply, state + amount, state + amount}
  end

  @impl true
  def handle_cast({:double}, state) do
    {:noreply, state * 2}
  end
end

defmodule DemoSupervisor do
  use Supervisor

  def start_link(init_value \\ 0) do
    Supervisor.start_link(__MODULE__, init_value, name: __MODULE__)
  end


  @impl true
  def init(init_value) do
    children = [
      {DemoGenServer, init_value}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule AllFeaturesDemo do
  import DemoMac
  require DemoMac

  def start_supervised_gen_server do
    {:ok, _sup_pid} = DemoSupervisor.start_link(10)
    {:ok, _server_pid} = DemoGenServer.start_link(10)
  end

  def increment_server(n) do
    GenServer.call(DemoGenServer, {:increment, n})
  end

  def double_server do
    GenServer.cast(DemoGenServer, {:double})
  end

  def demonstrate_macros do
    macro_add(5, 10)
  end

  def demonstrate_pattern_matching_and_recursion(list) do
    do_sum(list, 0)
  end

  defp do_sum([], acc), do: acc
  defp do_sum([h | t], acc), do: do_sum(t, acc + h)

  def pipeline_example(value) do
    value
    |> String.upcase()
    |> String.reverse()
  end

  def with_example(x, y) do
    with :ok <- validate_number(x),
         :ok <- validate_number(y),
         result = x + y do
      {:ok, result}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp validate_number(n) when is_number(n), do: :ok
  defp validate_number(_), do: {:error, :not_a_number}

  def comprehension_example do
    for x <- 1..5, y <- 1..5, rem(x*y, 2) == 0, do: {x, y, x*y}
  end

  def struct_example do
    struct = DemoStruct.new(42, "hello")
    upcased = DemoStruct.label_upcase(struct)
    {struct, upcased}
  end

  def protocol_example do
    int_str = DemoProtocol.to_string(123)
    string_str = DemoProtocol.to_string("abc")
    {int_str, string_str}
  end

  def spawn_process_example do
    pid = spawn(fn -> process_loop() end)
    send(pid, {:hello, "World"})
    pid
  end
end
