using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CharacHealth : MonoBehaviour
{

    [SerializeField] private int _maxHealth = 100;
    private int _currentHealth;

    [SerializeField] private Healthbar _healthBar = null;
  

    public int CurrentHealth
    {
        get
        {
            return _currentHealth;
        }
        set
        {
            _currentHealth = value;
            _currentHealth = Mathf.Clamp(_currentHealth, 0, _maxHealth); 
        }
    }

    public int MaxHealth
    {
        get
        { return _maxHealth; }
    }

    // Start is called before the first frame update
    void Start()
    {
        CurrentHealth = _maxHealth;
        _healthBar.SetMaxHealth(_maxHealth);
    }

    private void Update()
    {
        if(_currentHealth<=0)
        {
            SceneManager.LoadScene(1);
        }
    }


    public void TakeDamage(int damage)
    {
        CurrentHealth -= damage;
        _healthBar.SetHealth(CurrentHealth);
    }
    
    public void GetLifeBack(int heal)
    {
        CurrentHealth += heal;
        _healthBar.SetHealth(CurrentHealth);
    }
}
