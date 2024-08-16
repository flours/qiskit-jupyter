# qiskit-jupyter

# 実行方法

```
docker compose up 
```

# 使い方
localhost:8888 にアクセスすると、qiskitが使えるjupyter notebookが開きます。  
ipを制限しないので、プライベートネットワーク内ならアクセス可能です。
手元で修正する場合はdocker-compose.ymlを編集し、手元でbuildするよう設定してください。





デバッグ用便利スクリプト、solveを問題に合わせて適宜いじって使う

```python
from qiskit import QuantumCircuit
 
 
def solve(n: int, L: int) -> QuantumCircuit:
    qc = QuantumCircuit(n)
    # Write your code here:

    qc.h(0)
    return qc

def measure(qc, n):
    from qiskit import QuantumCircuit, ClassicalRegister
    from qiskit_aer import AerSimulator
    from qiskit import transpile
    # 古典ビットを持つレジスターを作成
    cr = ClassicalRegister(n)
    qc.add_register(cr)

    # 測定を追加
    qc.measure(list(range(n)), list(range(n)))

    # AerSimulatorを使用
    simulator = AerSimulator()

    # 回路をトランスパイル
    compiled_circuit = transpile(qc, simulator)

    # 回路を実行
    job = simulator.run(compiled_circuit, shots=1000)

    # 結果を取得
    result = job.result()

    # 測定結果のカウントを取得
    counts = result.get_counts(compiled_circuit)

    # 測定割合を確認
    print("測定結果:", counts)


def display_amplitudes(qc):
    from qiskit import QuantumCircuit, transpile
    from qiskit_aer import AerSimulator
    # AerSimulatorを使用（状態ベクトル用）
    simulator = AerSimulator()

    # 状態ベクトルを保存するように指示
    qc.save_statevector()

    # 回路をトランスパイル
    compiled_circuit = transpile(qc, simulator)

    # シミュレーターを実行
    job = simulator.run(compiled_circuit)

    # 結果を取得
    result = job.result()

    # 状態ベクトルを取得
    statevector = result.get_statevector(compiled_circuit)

    # 状態ベクトル（複素振幅）を表示
    print("状態ベクトル:", statevector)

# オラクル問題の時に使う一様分布作成機
def _debug(n):
    from qiskit import QuantumCircuit
    qc = QuantumCircuit(n)
    for i in range(n):
        qc.h(i)
    return qc

def showstate(n,qc):
    # オラクルの問題の場合は入力状態を作ってcomposeでつなげる
    # display_amplitudes(_debug(n).compose(qc).copy())
    display_amplitudes(qc.copy())

# ベクトル確認
n=1
L=1
showstate(n,solve(n,L))

# 測定
measure(solve(n,L),n)

# 測定後はベクトル壊れているので注意
showstate(n,solve(n,L))
```
