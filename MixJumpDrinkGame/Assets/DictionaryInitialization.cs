using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DictionaryInitialization : MonoBehaviour
{
    [SerializeField] TextAsset text;
    public Dictionary<string, string> drinksList;
    void Start()
    {
        string textSt = text.ToString();
        textSt = textSt.Replace("\n","");

        string[] textAr = textSt.Split(';');

        for (int i = 0; i < textAr.Length; i++)
        {
            string[] temp = textAr[i].Split('=');
            drinksList.Add(temp[0],temp[1]);
        }
    }

}
