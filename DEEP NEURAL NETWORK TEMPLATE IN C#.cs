//DEEP NEURAL NETWORK TEMPLATE
// This is a template for deep neural network in C#. This neural network has 5 layers.
//INPUT - Set the input in the MyMethod section.
//HIDDEN - The hidden nodes will adjust themself based on the weights
//TARGET - Set target based on the correct and acutal target of the output nodes. Target starts from 0 for the 1st output entry.
//WEIGHTS - All weights will adjust automatically.
//BIAS - All bias will adjust automatically.
//OUTPUT - Set out based on the number of possible predictive output.

using System;
using System.Collections.Generic;

namespace DeepNeuralNetwork
{
    
    public class Template
    {
        //INPUT
        public double[] input;
        public int inputLength = 10;

        //HIDDEN - SET THE NUMBER OF NODES
        public double[] hidden1 = new double[100];
        public double[] hidden2 = new double[100];
        public double[] hidden3 = new double[100];
        public double[] hidden4 = new double[100];

        //OUTPUT - SET THE NUMBER OF OUTPUT CATEGORIES. 
        public double[] output = new double[10];
        
        //WEIGHTS
        public double[,] weights1;
        public double[,] weights2;
        public double[,] weights3;
        public double[,] weights4;
        public double[,] weights5;
        public double[,] weights;

        //BIAS
        public double[] bias1;
        public double[] bias2;
        public double[] bias3;
        public double[] bias4;
        public double[] bias5;
        public double[] biases;        

        //TARGET
        public double target;

        public List<double> randomWeights;
        Random r;

        public bool initilize = true;

        public double[] sigmoid;
        public double[] softmax;
        public double[] oneHotEncoding;

        public double[] dOut1;
        public double[] dOut2;
        public double[] dOut3;
        public double[] dOut4;
        public double[] dOut5;

        public bool thrownInput = false;

        //SET LEARNING RATE
        public double learningRate = 0.1;

        protected override void OnStart()
        {
            //INPUT AND OUTPUT WEIGHTS & BIASES
            weights1 = new double[inputLength, hidden1.Length];
            weights2 = new double[hidden1.Length, hidden2.Length];
            weights3 = new double[hidden2.Length, hidden3.Length];
            weights4 = new double[hidden3.Length, hidden4.Length];
            weights5 = new double[hidden4.Length, output.Length];
            
            bias1 = new double[weights1.GetLength(1)];
            bias2 = new double[weights2.GetLength(1)];
            bias3 = new double[weights3.GetLength(1)];
            bias4 = new double[weights4.GetLength(1)];
            bias5 = new double[weights5.GetLength(1)];
            
            //INPUT - SET INPUT
            input = new double[10]
            {
                  250,
                  150,
                  500,
                  546,
                  44,
                  54,
                  98,
                  54,
                  614,
                  1
            };


            //SET TARGET AS OUTPUT INDEX (STARTING FROM 0)
            target = 1;

            //TARGET CANNOT BE MORE THAN OUTPUT
            if (target > output.Length - 1)
            {
                thrownInput = true;
                return;
            }

            //INTIALIZING WEIGHTS AND BIAS
            if (initilize)
            {
                //LAYER 1
                weights = weights1;
                biases = bias1;

                Initialization(weights, biases);

                weights1 = weights;
                bias1 = biases;

                //LAYER 2
                weights = weights2;
                biases = bias2;

                Initialization(weights, biases);

                weights2 = weights;
                bias2 = biases;

                //LAYER 3
                weights = weights3;
                biases = bias3;

                Initialization(weights, biases);

                weights3 = weights;
                bias3 = biases;

                //LAYER 4
                weights = weights4;
                biases = bias4;

                Initialization(weights, biases);

                weights4 = weights;
                bias4 = biases;

                //LAYER 5
                weights = weights5;
                biases = bias5;

                Initialization(weights, biases);

                weights5 = weights;
                bias5 = biases;

                initilize = false;

            }

            ForwardPropagation();

            if (thrownInput == false)
            {
                BackPropagation();

            }

        }

        public void Initialization(double[,] weights, double[] biases)
        {
            //WEIGHT RANDOMIZATION
            randomWeights = new List<double>();

            double weightInitializationLayer = weights.GetLength(0) * weights.GetLength(1);

            for (int i = 0; i < weightInitializationLayer; i++)
            {
                r = new Random();
                double selectWeight = Math.Round(r.NextDouble(), 15);
                if (!randomWeights.Contains(selectWeight))
                {
                    randomWeights.Add(selectWeight);
                }
                else if (randomWeights.Contains(selectWeight))
                {
                    i--;
                }

            }

            //NORMALIZATION - HE INITIALIZATION
            double heInitializer = Math.Round(Math.Sqrt(2) / Math.Sqrt(weightInitializationLayer), 15);

            //WEIGHTS INITIALIZATION
            int weightCount = 0;
            for (int i = 0; i < weights.GetLength(0); i++)
            {
                for (int j = 0; j < weights.GetLength(1); j++)
                {
                    if (weightCount < weightInitializationLayer)
                    {
                        weights[i, j] = Math.Round(randomWeights[weightCount] * heInitializer, 15);
                        weightCount++;
                    }

                }
            }

            //BIASES INITIALIZATION
            for (int i = 0; i < biases.Length; i++)
            {
                biases[i] = 0;
            }

        }

        public void ForwardPropagation()
        {
            //INPUT NORMALIZATION
            double mean = Math.Round(input.Average(), 15);

            double variance = 0;
            for (int i = 0; i < input.Length; i++)
            {
                variance += Math.Round(Math.Pow(input[i] - mean, 2), 15);
            }

            variance /= input.Length;

            //INPUT LAYERNORMALIZATION
            for (int i = 0; i < input.Length; i++)
            {
                input[i] = Math.Round(((input[i] - mean) / variance), 15);

                if (Double.IsNaN(input[i]))
                {
                    thrownInput = true;
                    i = input.Count();
                    return;

                }

            }

            //LAYER 1 - INPUT
            hidden1 = new double[weights1.GetLength(1)];
            for (int j = 0; j < weights1.GetLength(1); j++)
            {   
                for (int i = 0; i < weights1.GetLength(0); i++)
                {
                    hidden1[j] += Math.Round(input[i] * weights1[i, j], 15);
                }

            }

            for (int i = 0; i < hidden1.Length; i++)
            {

                hidden1[i] += bias1[i];

            }

            //LAYER 2
            hidden2 = new double[weights2.GetLength(1)];
            for (int j = 0; j < weights2.GetLength(1); j++)
            {
                for (int i = 0; i < weights2.GetLength(0); i++)
                {
                    hidden2[j] += Math.Round(hidden1[i] * weights2[i, j], 15);
                }

            }


            for (int i = 0; i < hidden2.Length; i++)
            {

                hidden2[i] += bias2[i];

            }

            //LAYER 3
            hidden3 = new double[weights3.GetLength(1)];
            for (int j = 0; j < weights3.GetLength(1); j++)
            {
                for (int i = 0; i < weights3.GetLength(0); i++)
                {
                    hidden3[j] += Math.Round(hidden2[i] * weights3[i, j], 15);
                }

            }

            for (int i = 0; i < hidden3.Length; i++)
            {

                hidden3[i] += bias3[i];

            }

            //LAYER 4
            hidden4 = new double[weights4.GetLength(1)];
            for (int j = 0; j < weights4.GetLength(1); j++)
            {
                for (int i = 0; i < weights4.GetLength(0); i++)
                {
                    hidden4[j] += Math.Round(hidden3[i] * weights4[i, j], 15);
                }

            }

            for (int i = 0; i < hidden4.Length; i++)
            {

                hidden4[i] += bias4[i];

            }

            //LAYER 5 - OUTPUT
            for (int j = 0; j < weights5.GetLength(1); j++)
            {
                for (int i = 0; i < weights5.GetLength(0); i++)
                {
                    output[j] += Math.Round(hidden4[i] * weights5[i, j], 15);
                }

            }

            for (int i = 0; i < output.Length; i++)
            {

                output[i] += bias5[i];

            }

            if (output.Length < 3)
            {

                sigmoid = new double[output.Length];
                for (int i = 0; i < output.Length; i++)
                {
                    sigmoid[i] = Math.Round((1 / (1 + Math.Exp(-output[i]))), 15);
                    Print("SIGMOID: {0}", sigmoid[i]);
                }

            }

            if (output.Length > 2)
            {
                softmax = new double[output.Length];
                for (int i = 0; i < output.Length; i++)
                {
                    softmax[i] = Math.Round(Math.Exp(output[i] / output.Sum()), 15);
                    Print("SOFTMAX: {0}", softmax[i]);
                }
            }

            //ONE HOT ENCODING
            oneHotEncoding = new double[output.Length];

            for (int i = 0; i < oneHotEncoding.Length; i++)
            {
                if (target != i)
                {
                    oneHotEncoding[i] = 0;
                }

                if (target == i)
                {
                    oneHotEncoding[i] = 1;

                }

            }

        }

        public void BackPropagation()
        {
            if (output.Length < 3)
            {
                double[] dSigmoid = new double[2]
                {
                        Math.Round(sigmoid[0] - oneHotEncoding[0],15),
                        Math.Round(sigmoid[1] - oneHotEncoding[1],15)

                };

                dOut5 = new double[2];
                for (int i = 0; i < dSigmoid.Length; i++)
                {
                    dOut5[i] = dSigmoid[i];
                }
            }


            if (output.Length > 2)
            {
                double[] dSoftmax = new double[output.Length];
                dOut5 = new double[output.Length];
                for (int i = 0; i < dSoftmax.Length; i++)
                {
                    dSoftmax[i] = Math.Round(Math.Exp(softmax[i] - oneHotEncoding[i]), 15);
                    dOut5[i] = dSoftmax[i];
                }


            }

            //DIFFRENTIATION & UPDATING BIAS            
            for (int i = 0; i < dOut5.Length; i++)
            {
                bias5[i] -= Math.Round(learningRate * dOut5[i], 15);

            }

            dOut4 = new double[weights5.GetLength(0)];
            for (int i = 0; i < dOut4.Length; i++)
            {

                bias4[i] -= Math.Round(learningRate * dOut4[i], 15);

                for (int j = 0; j < dOut5.Length; j++)
                {
                    dOut4[i] += hidden4[j] * dOut5[j];
                }

            }

            dOut3 = new double[weights4.GetLength(0)];
            for (int i = 0; i < dOut3.Length; i++)
            {
                bias3[i] -= Math.Round(learningRate * dOut3[i], 15);

                for (int j = 0; j < dOut4.Length; j++)
                {
                    dOut3[i] += hidden3[j] * dOut4[j];
                }

            }

            dOut2 = new double[weights3.GetLength(0)];
            for (int i = 0; i < dOut2.Length; i++)
            {
                bias2[i] -= Math.Round(learningRate * dOut2[i], 15);

                for (int j = 0; j < dOut3.Length; j++)
                {
                    dOut2[i] += hidden2[j] * dOut3[i];

                }

            }

            dOut1 = new double[weights2.GetLength(0)];
            for (int i = 0; i < dOut1.Length; i++)
            {
                bias1[i] -= Math.Round(learningRate * dOut1[i], 15);

                for (int j = 0; j < dOut2.Length; j++)
                {
                    dOut1[i] += hidden1[j] * dOut2[i];

                }

            }

            //UPDATING WEIGHTS
            int count = 0;
            for (int i = 0; i < weights5.GetLength(0); i++)
            {
                for (int j = 0; j < weights5.GetLength(1); j++)
                {
                    weights5[i, j] -= Math.Round(learningRate * dOut4[count], 15);

                }

                count++;

            }

            count = 0;
            for (int i = 0; i < weights4.GetLength(0); i++)
            {
                for (int j = 0; j < weights4.GetLength(1); j++)
                {
                    weights4[i, j] -= Math.Round(learningRate * dOut3[count], 15);

                }
                count++;
            }

            count = 0;
            for (int i = 0; i < weights3.GetLength(0); i++)
            {
                for (int j = 0; j < weights3.GetLength(1); j++)
                {
                    weights3[i, j] -= Math.Round(learningRate * dOut2[count], 15);

                }
                count++;
            }

            count = 0;
            for (int i = 0; i < weights2.GetLength(0); i++)
            {
                for (int j = 0; j < weights2.GetLength(1); j++)
                {
                    weights2[i, j] -= Math.Round(learningRate * dOut1[count], 15);

                }
                count++;
            }

            count = 0;
            for (int i = 0; i < weights1.GetLength(0); i++)
            {
                for (int j = 0; j < weights1.GetLength(1); j++)
                {
                    weights1[i, j] -= Math.Round(learningRate * input[i] * dOut1[count], 15);
                }

                count++;
            }

        }
    }

}
