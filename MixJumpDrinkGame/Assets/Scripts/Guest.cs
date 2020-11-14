using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;



public class Guest : MonoBehaviour
{

    public GameObject dictionaryInt;

    [SerializeField] public int DrinkNum = 0;
    [SerializeField] public float timeToServe = 0f;
    [SerializeField] public bool makeOrder = false;
    [SerializeField] private bool needOrder = false;



    void Start()
    {

        Random.InitState(System.DateTime.Now.Millisecond);
        DrinkNum = Random.Range(0, dictionaryInt.GetComponent<DictionaryInt>().drinksList.Keys.Count );
        print(DrinkNum);
        
    }

    void Update()
    {
        if (makeOrder)
        {
            DrinkNum = Random.Range(0, dictionaryInt.GetComponent<DictionaryInt>().drinksList.Keys.Count);
            timeToServe = 30f;
            makeOrder = false;
            needOrder = true;
            print("new order");
            print(DrinkNum);
        }

        if (timeToServe > 0 && needOrder)
        {
            timeToServe -= Time.deltaTime;
        }

        if (timeToServe < 0 && needOrder)
        {
            timeToServe = 0;
        }

        if (timeToServe == 0)
        {
            print("Suck my ass");
            timeToServe = -1;
            needOrder = false;
        }
    }

}
