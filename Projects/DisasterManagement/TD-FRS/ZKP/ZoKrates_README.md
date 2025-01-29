
# ZoKrates ZKP Circuit Creation and Proof Verification

In this project, a simple Zero-Knowledge Proof (ZKP) circuit is created using ZoKrates, and the process of proof generation and verification is explained.

## Starting: Run ZoKrates Docker Container

```bash
docker run -ti zokrates/zokrates /bin/bash
```
This command starts the ZoKrates Docker container and opens a bash terminal where you can use ZoKrates commands.

## Create a New Project Directory

```bash
mkdir zkp-circuit
```
This command creates a new directory named `zkp-circuit` where ZoKrates circuits will be written.

## Navigate into the Project Directory

```bash
cd zkp-circuit
```
This command navigates into the newly created `zkp-circuit` directory.

## Create ZoKrates Circuit File

```bash
touch circuit.zok
```
This command creates an empty `circuit.zok` file where you will define your ZoKrates circuit.

## Write the Circuit

```bash
echo 'def main(private field memberId, field orgId) -> bool {
    return memberId == orgId;
}' > circuit.zok
```
This command writes a simple ZoKrates circuit in the `circuit.zok` file. The circuit checks if the `memberId` equals the `orgId` and returns `true` if they are equal.

## View the Circuit

```bash
cat circuit.zok
```
This command displays the content of the `circuit.zok` file in the terminal so you can review the code you wrote.

## Compile the Circuit

```bash
zokrates compile -i circuit.zok
```
This command compiles the `circuit.zok` file. If the compilation is successful, you will see the message "Compiled code written to 'out'".

## Compute the Witness

```bash
zokrates compute-witness -a 123 123
```
This command generates a witness file based on the arguments you provide, such as `memberId` and `orgId`. Here, `123 123` are example arguments, which would typically be membership and organization IDs.

## ZoKrates Setup (Generate Keys)

```bash
zokrates setup
```
This command generates the necessary verification and proving keys for the ZKP circuit. These keys are used during the proof generation and verification steps. The keys are saved as `proving.key` and `verification.key`.

## Generate the Proof

```bash
zokrates generate-proof
```
This command generates the proof file (`proof.json`) based on the computed witness. The proof demonstrates the validity of the conditions in the circuit.

## Verify the Proof

```bash
zokrates verify
```
This command verifies the proof you generated. If the verification is successful, it will confirm that the proof is valid.
