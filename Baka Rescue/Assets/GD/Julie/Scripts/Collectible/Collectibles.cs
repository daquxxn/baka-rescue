using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Collectibles : MonoBehaviour
{
    [SerializeField] private CharacController _characController = null;
    [SerializeField] private Healthbar _healthBar = null;

    [SerializeField] private int _lifeHealed = 20;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        gameObject.SetActive(false);
        if (_characController.CurrentHealth < 100)
            GetLifeBack(_lifeHealed);

    }

    private void GetLifeBack(int heal)
    {
      _characController.CurrentHealth += heal;
     _healthBar.SetHealth(_characController.CurrentHealth);
    }
}
