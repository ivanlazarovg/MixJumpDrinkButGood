using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;

public class ClosetPick : MonoBehaviour
{
    [SerializeField]
    private Text text;

    [SerializeField]
    private LayerMask layermask1;

    [SerializeField]
    private LayerMask layermask2;

    [SerializeField]
    public Guest guest;

    [SerializeField]
    private float radius;

    [SerializeField]
    private int hp = 3;

    List<char> inventory = new List<char>();

    public DictionaryInt dictionaryInt;

    private void Start()
    {
        text.text = "empty";
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;


            if (Physics.Raycast(ray, out hit, radius,layermask1))
            {
               
                    char Alc = hit.transform.gameObject.GetComponent<Supply>().alcohol;
                    char Addon = hit.transform.gameObject.GetComponent<Supply>().addon;

                    if (Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
                    {
                        inventory.Add(Addon);
                    }
                    else
                    {
                        inventory.Add(Alc);
                    }

                    text.text = string.Join("", inventory);
               
               
                
            }
            if (Physics.Raycast(ray, out hit, radius, layermask2))
            {
                     
                Guest guesttarget = hit.transform.gameObject.GetComponent<Guest>();
                Debug.Log(LoopThroughString(guesttarget));
               

            }


        }

        if (Input.GetKeyDown(KeyCode.R))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, radius, layermask2))
            {

                Guest guesttarget = hit.transform.gameObject.GetComponent<Guest>();
                guesttarget.makeOrder = true;
                inventory.Clear();
                text.text = "empty";

            }
        }

    }

    public string LoopThroughString(Guest guesttarget)
    {
        if(dictionaryInt.drinksList.ElementAt(guesttarget.DrinkNum).Value.Length != inventory.Count)
        {
            return "bad";
        }
        for (int i = 0; i < inventory.Count; i++)
        {
            if (!dictionaryInt.drinksList.ElementAt(guesttarget.DrinkNum).Value.Contains(inventory[i]))

            {
                return "bad";
            }
        }
        
        return "good";
    }

    
}
